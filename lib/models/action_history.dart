class ActionHistory {
  final int id;
  final String date;
  String situation;
  String thoughts;
  String mood;
  List<String> emotion;
  String behaviors;
  String reactions;
  bool isExpanded;

  ActionHistory({
    required this.id,
    required this.date,
    this.situation = "",
    this.thoughts = "",
    this.mood = "",
    required this.emotion,
    this.behaviors = "",
    this.reactions = "",
    this.isExpanded = false,
  });
}
