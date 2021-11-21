/// An error flag at a location in the questionnaire.
///
/// Combines a location of a response item ([nodeUid]),
/// and an optional error text (such as the output of a validator).
class QuestionnaireErrorFlag {
  final String nodeUid;
  final String? errorText;

  const QuestionnaireErrorFlag(
    this.nodeUid, {
    this.errorText,
  });
}
