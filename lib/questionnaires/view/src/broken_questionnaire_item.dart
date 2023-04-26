import 'dart:convert';

import 'package:faiadashu/questionnaires/questionnaires.dart';
import 'package:fhir/r4.dart';
import 'package:flutter/material.dart';

/// A place-holder for a broken item on a questionnaire.
/// Can display error information.
class BrokenQuestionnaireItem extends StatelessWidget {
  final String message;
  final Object? element;
  final Object? cause;

  const BrokenQuestionnaireItem(
    this.message,
    this.element,
    this.cause, {
    super.key,
  });

  /// Construct the item from an exception.
  /// Special support for [QuestionnaireFormatException].
  BrokenQuestionnaireItem.fromException(Object exception, {super.key})
      : message = (exception is QuestionnaireFormatException)
            ? exception.message
            : exception.toString(),
        element = (exception is QuestionnaireFormatException)
            ? exception.element
            : null,
        cause = (exception is QuestionnaireFormatException)
            ? exception.cause
            : null;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.error,
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (cause != null)
              SelectableText(
                cause.toString(),
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Theme.of(context).cardColor,
                    ),
              ),
            SelectableText(
              message,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.yellow,
                  ),
            ),
            if (element != null)
              SelectableText(
                (element is Resource)
                    ? jsonEncode((element! as Resource).toJson())
                    : (element is QuestionnaireItem)
                        ? jsonEncode((element! as QuestionnaireItem).toJson())
                        : element.toString(),
              ),
          ],
        ),
      ),
    );
  }
}
