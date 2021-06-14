import 'package:faiadashu/l10n/l10n.dart';
import 'package:faiadashu/questionnaires/questionnaires.dart';
import 'package:faiadashu/resource_provider/resource_provider.dart';
import 'package:faiadashu_online/restful/restful.dart';
import 'package:faiadashu_online/url_launch/src/url_launcher.dart';
import 'package:fhir/r4.dart';
import 'package:flutter/material.dart';

/// Tile that launches a [QuestionnaireScrollerPage] when tapped.
class QuestionnaireLaunchTile extends StatefulWidget {
  final String title;
  final String? subtitle;
  final String questionnairePath;
  final Locale? locale;
  final FhirResourceProvider fhirResourceProvider;
  final void Function(String id, QuestionnaireResponse? questionnaireResponse)
      saveResponseFunction;
  final void Function(String id, QuestionnaireResponse? questionnaireResponse)?
      uploadResponseFunction;
  final QuestionnaireResponse? Function(String id) restoreResponseFunction;

  const QuestionnaireLaunchTile(
      {required this.title,
      this.subtitle,
      this.locale,
      required this.questionnairePath,
      required this.fhirResourceProvider,
      required this.saveResponseFunction,
      this.uploadResponseFunction,
      required this.restoreResponseFunction,
      Key? key})
      : super(key: key);

  @override
  _QuestionnaireLaunchTileState createState() =>
      _QuestionnaireLaunchTileState();
}

class _QuestionnaireLaunchTileState extends State<QuestionnaireLaunchTile> {
  late final FhirResourceProvider _questionnaireProvider;
  int _numberCompleted = 0;
  double _percentageCompleted = 0;
  int _totalNumber = 0;

  @override
  void initState() {
    super.initState();
    _questionnaireProvider = AssetResourceProvider.singleton(
        questionnaireResourceUri, widget.questionnairePath);
    final locale = widget.locale ?? Locale.fromSubtags(languageCode: 'en');
    QuestionnaireModel
        .fromFhirResourceBundle(
            fhirResourceProvider: _questionnaireProvider,
            locale: locale,
            aggregators: [NarrativeAggregator()]).then((value) => setState(() {
          _numberCompleted = value.numberItemsAnswered;
          _percentageCompleted = value.percentageItemsAnswered;
          _totalNumber = value.totalNumberItems;
        }));
  }

  @override
  Widget build(BuildContext context) {
    final locale = widget.locale ?? Localizations.localeOf(context);

    return ListTile(
      title: Text('${widget.title}\n'
          'Completed: $_numberCompleted / $_totalNumber '
          '(${(_percentageCompleted * 100).toStringAsPrecision(2)}%)'),
      subtitle: (widget.subtitle != null) ? Text(widget.subtitle!) : null,
      trailing: SizedBox(
        width: 24.0,
        height: 40.0,
        child: Center(
          child: IconButton(
            icon: const Icon(Icons.preview),
            onPressed: () async {
              final questionnaireModel =
                  await QuestionnaireModel.fromFhirResourceBundle(
                      fhirResourceProvider: _questionnaireProvider,
                      locale: locale,
                      aggregators: [NarrativeAggregator()]);
              questionnaireModel.populate(widget.restoreResponseFunction
                  .call(widget.questionnairePath));
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NarrativePage(
                            questionnaireModel: questionnaireModel,
                          )));
            },
          ),
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => QuestionnaireScrollerPage(
                locale: locale,
                fhirResourceProvider: RegistryFhirResourceProvider([
                  AssetResourceProvider.singleton(
                      questionnaireResourceUri, widget.questionnairePath),
                  InMemoryResourceProvider.inMemory(
                      questionnaireResponseResourceUri,
                      widget.restoreResponseFunction(widget.questionnairePath)),
                  widget.fhirResourceProvider
                ]),
                // Callback for supportLink
                onLinkTap: launchUrl,
                persistentFooterButtons: [
                  Builder(
                    builder: (context) => const QuestionnaireCompleteButton(),
                  ),
                  if (widget.uploadResponseFunction != null)
                    Builder(
                      builder: (context) => ElevatedButton.icon(
                        label: Text(FDashLocalizations.of(context)
                            .handlingUploadButtonLabel),
                        icon: const Icon(Icons.cloud_upload),
                        onPressed: () {
                          // Generate a response and upload it to a FHIR server.
                          // TODO: In a real-world scenario this should have more state handling.
                          widget.uploadResponseFunction?.call(
                              widget.questionnairePath,
                              QuestionnaireFiller.of(context)
                                  .aggregator<QuestionnaireResponseAggregator>()
                                  .aggregate(
                                      responseStatus:
                                          QuestionnaireResponseStatus
                                              .completed));
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(FDashLocalizations.of(context)
                                        .handlingUploading),
                                    SyncIndicator(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    )
                                  ]),
                            ),
                          );
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  Builder(
                    builder: (context) => ElevatedButton.icon(
                      label: Text(FDashLocalizations.of(context)
                          .handlingSaveButtonLabel),
                      icon: const Icon(Icons.save_alt),
                      onPressed: () {
                        // Generate a response and store it in-memory.
                        // In a real-world scenario one would persist or post the response instead.
                        widget.saveResponseFunction.call(
                            widget.questionnairePath,
                            QuestionnaireFiller.of(context)
                                .aggregator<QuestionnaireResponseAggregator>()
                                .aggregate());
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                                FDashLocalizations.of(context).handlingSaved)));
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ]),
          ),
        );
      },
    );
  }
}
