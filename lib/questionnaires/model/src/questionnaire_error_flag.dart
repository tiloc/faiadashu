/// An error flag at a location in the questionnaire.
///
/// Combines a location of an item ([linkId]), an optional index of an answer,
/// and an optional error text (such as the output of a validator).
class QuestionnaireErrorFlag {
  final String linkId;
  final int? answerIndex;
  final String? errorText;

  const QuestionnaireErrorFlag(this.linkId, {this.answerIndex, this.errorText});
}
