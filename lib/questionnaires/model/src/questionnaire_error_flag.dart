/// An error flag at a location in the questionnaire.
///
/// Combines a location of a response item ([responseUid]),
/// and an optional error text (such as the output of a validator).
class QuestionnaireErrorFlag {
  final String responseUid;
  final String? errorText;

  const QuestionnaireErrorFlag(
    this.responseUid, {
    this.errorText,
  });
}
