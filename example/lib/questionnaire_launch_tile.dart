import 'package:faiadashu/l10n/l10n.dart';
import 'package:faiadashu/questionnaires/questionnaires.dart';
import 'package:faiadashu/resource_provider/resource_provider.dart';
import 'package:faiadashu_online/restful/restful.dart';
import 'package:faiadashu_online/url_launch/src/url_launcher.dart';
import 'package:fhir/r4.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// Tile that launches a [QuestionnaireScrollerPage] when tapped.
class QuestionnaireLaunchTile extends StatefulWidget {
  final String title;
  final String? subtitle;
  final String questionnairePath;
  final Locale? locale;
  final FhirResourceProvider fhirResourceProvider;
  final LaunchContext launchContext;
  final void Function(String id, QuestionnaireResponse? questionnaireResponse)
      saveResponseFunction;
  final void Function(String id, QuestionnaireResponse? questionnaireResponse)?
      uploadResponseFunction;
  final QuestionnaireResponse? Function(String id) restoreResponseFunction;

  final QuestionnaireModelDefaults questionnaireModelDefaults;

  const QuestionnaireLaunchTile({
    required this.title,
    this.subtitle,
    this.locale,
    required this.questionnairePath,
    required this.fhirResourceProvider,
    required this.launchContext,
    required this.saveResponseFunction,
    this.uploadResponseFunction,
    required this.restoreResponseFunction,
    this.questionnaireModelDefaults = const QuestionnaireModelDefaults(),
    Key? key,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _QuestionnaireLaunchTileState createState() =>
      _QuestionnaireLaunchTileState();
}

class _QuestionnaireLaunchTileState extends State<QuestionnaireLaunchTile> {
  late final FhirResourceProvider _questionnaireProvider;
  late Locale _locale;
  late NumberFormat _percentPattern;
  late Future<QuestionnaireResponseModel> _modelFuture;

  @override
  void initState() {
    super.initState();
    _questionnaireProvider = AssetResourceProvider.singleton(
      questionnaireResourceUri,
      widget.questionnairePath,
    );
  }

  Future<QuestionnaireResponseModel> _createModelFuture() {
    return QuestionnaireResponseModel.fromFhirResourceBundle(
      fhirResourceProvider: _questionnaireProvider,
      launchContext: widget.launchContext,
      locale: _locale,
    ).then<QuestionnaireResponseModel>((qrm) {
      qrm.populate(
        widget.restoreResponseFunction.call(widget.questionnairePath),
      );
      return qrm;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _locale = widget.locale ?? Localizations.localeOf(context);
    _percentPattern = NumberFormat.percentPattern(_locale.toString());
    _modelFuture = _createModelFuture();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.title),
      subtitle: FutureBuilder<QuestionnaireResponseModel>(
        future: _modelFuture,
        builder: (context, snapshot) {
          var countString = '';
          if (snapshot.hasData) {
            // FIXME: Sometimes these stats are not being shown. Handle snapshot error.
            final _questionnaireResponseModel = snapshot.data!;
            final _numberCompleted =
                _questionnaireResponseModel.count((rim) => rim.isAnswered);
            final _totalNumber =
                _questionnaireResponseModel.count((rim) => rim.isAnswerable);
            countString = 'Completed: $_numberCompleted / $_totalNumber '
                '(${_percentPattern.format(_numberCompleted / _totalNumber)})';
          }

          return (widget.subtitle != null)
              ? Text('${widget.subtitle!}\n$countString')
              : Text(countString);
        },
      ),
      isThreeLine: true,
      trailing: SizedBox(
        width: 24.0,
        height: 40.0,
        child: Center(
          child: IconButton(
            icon: const Icon(Icons.preview),
            onPressed: () {
              final questionnaireResponse =
                  widget.restoreResponseFunction.call(widget.questionnairePath);
              if (questionnaireResponse == null) {
                // This is just a quick fix to prevent NPEs, in production code the button should be dimmed.
                return;
              }
              final narrative = questionnaireResponse.text!;
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NarrativePage(
                    narrative: narrative,
                  ),
                ),
              );
            },
          ),
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => QuestionnaireScrollerPage(
              locale: _locale,
              fhirResourceProvider: RegistryFhirResourceProvider([
                AssetResourceProvider.singleton(
                  questionnaireResourceUri,
                  widget.questionnairePath,
                ),
                InMemoryResourceProvider.inMemory(
                  questionnaireResponseResourceUri,
                  widget.restoreResponseFunction(
                    widget.questionnairePath,
                  ),
                ),
                widget.fhirResourceProvider,
              ]),
              launchContext: widget.launchContext,
              // Callback for supportLink
              onLinkTap: launchLink,
              persistentFooterButtons: [
                Builder(
                  builder: (context) => const QuestionnaireCompleteButton(),
                ),
                if (widget.uploadResponseFunction != null)
                  Builder(
                    builder: (context) => ElevatedButton.icon(
                      label: Text(
                        FDashLocalizations.of(context)
                            .handlingUploadButtonLabel,
                      ),
                      icon: const Icon(Icons.cloud_upload),
                      onPressed: () {
                        // Generate a response and upload it to a FHIR server.
                        // In a real-world scenario this would have more robust state handling.
                        widget.uploadResponseFunction?.call(
                          widget.questionnairePath,
                          QuestionnaireResponseFiller.of(context)
                              .aggregator<QuestionnaireResponseAggregator>()
                              .aggregate(
                                responseStatus:
                                    QuestionnaireResponseStatus.completed,
                              ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  FDashLocalizations.of(context)
                                      .handlingUploading,
                                ),
                                SyncIndicator(
                                  color: Theme.of(context).colorScheme.primary,
                                )
                              ],
                            ),
                          ),
                        );
                        Navigator.pop(context);
                      },
                    ),
                  ),
                Builder(
                  builder: (context) => ElevatedButton.icon(
                    label: Text(
                      FDashLocalizations.of(context).handlingSaveButtonLabel,
                    ),
                    icon: const Icon(Icons.save_alt),
                    onPressed: () {
                      // Generate a response and store it in-memory.
                      // In a real-world scenario one would persist or post the response instead.
                      widget.saveResponseFunction.call(
                        widget.questionnairePath,
                        QuestionnaireResponseFiller.of(context)
                            .aggregator<QuestionnaireResponseAggregator>()
                            .aggregate(),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            FDashLocalizations.of(context).handlingSaved,
                          ),
                        ),
                      );
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
              questionnaireModelDefaults: widget.questionnaireModelDefaults,
            ),
          ),
        ).then((value) {
          // This triggers after return from questionnaire filler
          setState(() {
            _modelFuture = _createModelFuture();
          });
        });
      },
    );
  }
}
