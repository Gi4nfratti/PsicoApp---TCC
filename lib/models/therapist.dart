class Therapist {
  final int id;
  final String name;
  final String photo;
  final String desc;
  final String type;
  final String state;
  final String approach;
  final bool isAvailable;

  const Therapist({
    required this.type,
    required this.state,
    required this.approach,
    required this.id,
    required this.name,
    required this.photo,
    required this.desc,
    required this.isAvailable,
  });
}
