/// A marker at a location in the questionnaire.
///
/// Combines a location of an item ([linkId]), an optional index of an answer,
/// and an optional annotation (such as the output of a validator).
class QuestionnaireMarker {
  final String linkId;
  final int? answerIndex;
  final String? annotation;

  const QuestionnaireMarker(this.linkId, {this.answerIndex, this.annotation});
}
