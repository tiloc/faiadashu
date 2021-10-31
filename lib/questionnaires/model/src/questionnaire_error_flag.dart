/// An error flag at a location in the questionnaire.
///
/// Combines a location of a response item ([responseUid]), an optional index of an answer,
/// and an optional error text (such as the output of a validator).
class QuestionnaireErrorFlag {
  final String responseUid;
  final int? answerIndex;
  final String? errorText;

  const QuestionnaireErrorFlag(
    this.responseUid, {
    this.answerIndex,
    this.errorText,
  });
}
