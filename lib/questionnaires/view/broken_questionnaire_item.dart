import 'package:fhir/r4/resource/resource.dart';
import 'package:flutter/material.dart';

import '../../faiadashu.dart';

/// A place-holder for a broken item on a questionnaire.
/// Can display error information.
class BrokenQuestionnaireItem extends StatelessWidget {
  final String message;
  final Object? element;
  final Object? cause;

  const BrokenQuestionnaireItem(this.message, this.element, this.cause,
      {Key? key})
      : super(key: key);

  /// Construct the item from an exception.
  /// Special support for [QuestionnaireFormatException].
  BrokenQuestionnaireItem.fromException(Object exception, {Key? key})
      : message = (exception is QuestionnaireFormatException)
            ? exception.message
            : exception.toString(),
        element = (exception is QuestionnaireFormatException)
            ? exception.element
            : null,
        cause = (exception is QuestionnaireFormatException)
            ? exception.cause
            : null,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        color: Colors.red,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (cause != null)
              Text(
                cause.toString(),
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
            if (element != null)
              Text((element is Resource)
                  ? (element! as Resource).toJson().toString()
                  : element.toString())
          ],
        ));
  }
}
