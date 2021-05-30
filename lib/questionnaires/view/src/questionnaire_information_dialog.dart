import 'package:fhir/r4.dart' show Questionnaire;
import 'package:flutter/material.dart';

import 'questionnaire_information_tile.dart';

/// A dialog containing a [QuestionnaireInformationTile].
class QuestionnaireInformationDialog {
  static Future<void> showQuestionnaireInfo(
      BuildContext context,
      Locale locale,
      Questionnaire questionnaire,
      void Function(BuildContext context)? onClose) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Localizations.override(
                context: context,
                locale: locale,
                child: Builder(
                    builder: (context) => Text(MaterialLocalizations.of(context)
                        .aboutListTileTitle(questionnaire.title ?? 'Survey')))),
            content: QuestionnaireInformationTile(questionnaire),
            actions: <Widget>[
              OutlinedButton(
                onPressed: () => onClose?.call(context),
                child: Localizations.override(
                    context: context,
                    locale: locale,
                    child: Builder(
                        builder: (context) => Text(
                            MaterialLocalizations.of(context)
                                .closeButtonLabel))),
              ),
            ],
          );
        });
  }
}
