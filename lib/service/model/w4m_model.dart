class W4mModel {
  final String name;
  final int phoneNumber;
  final String? place;
  final int walkCount;

  const W4mModel({
    required this.name,
    required this.phoneNumber,
    this.place,
    required this.walkCount,
  });
}
