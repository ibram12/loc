class AdminHallModel {
  final String name;
  final String image;
  final String floor;
  final bool isBooked;
  final int reversationsCount;

  AdminHallModel({
    required this.reversationsCount,
    required this.name,
    required this.image,
    required this.floor,
    required this.isBooked,
  });
  factory AdminHallModel.fromJson(Map<String, dynamic> json, int count) {
    return AdminHallModel(
      reversationsCount: count,
      name: json['name'],
      image: json['image'],
      floor: json['floor'],
      isBooked: json['available'],
    );
  }
}
