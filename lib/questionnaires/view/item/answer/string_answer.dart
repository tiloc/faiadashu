import 'package:fhir/r4.dart';
import 'package:flutter/material.dart';

import '../../../../coding/data_absent_reasons.dart';
import '../../../model/item/string_item_model.dart';
import '../../../questionnaires.dart';
import '../questionnaire_answer_filler.dart';

class StringAnswer extends QuestionnaireAnswerFiller {
  const StringAnswer(
      QuestionnaireLocation location, AnswerLocation answerLocation,
      {Key? key})
      : super(location, answerLocation, key: key);
  @override
  State<StatefulWidget> createState() => _StringAnswerState();
}

class _StringAnswerState
    extends QuestionnaireAnswerState<String, StringAnswer> {
  late final StringItemModel _itemModel;

  final _controller = TextEditingController();

  _StringAnswerState();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _itemModel = StringItemModel(location);

    initialValue = widget.answerLocation.answer?.valueString;
    _controller.text = value ?? '';
  }

  @override
  Widget buildReadOnly(BuildContext context) {
    return Text(value ?? '');
  }

  @override
  Widget buildEditable(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(top: 8, bottom: 8),
        child: TextFormField(
          keyboardType: TextInputType.text,
          controller: _controller,
          maxLines: (qi.type == QuestionnaireItemType.text) ? 4 : 1,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            hintText: _itemModel.entryFormat,
          ),
          validator: (inputValue) => _itemModel.validate(inputValue),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          onChanged: (content) {
            value = content;
          },
          maxLength: _itemModel.maxLength,
        ));
  }

  @override
  QuestionnaireResponseAnswer? fillAnswer() {
    final valid = _itemModel.validate(value) == null;
    final dataAbsentReasonExtension = !valid
        ? [
            FhirExtension(
                url: DataAbsentReason.extensionUrl,
                valueCode: DataAbsentReason.asTextCode)
          ]
        : null;

    return (value != null && value!.isNotEmpty)
        ? (qi.type != QuestionnaireItemType.url)
            ? QuestionnaireResponseAnswer(
                valueString: value, extension_: dataAbsentReasonExtension)
            : QuestionnaireResponseAnswer(
                valueUri: FhirUri(value), extension_: dataAbsentReasonExtension)
        : null;
  }
}
