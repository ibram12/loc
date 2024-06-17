class HallModel {
  final String name;
  final String image;
  final String floor;
  final bool isBooked;


  HallModel({

    required this.name,
    required this.image,
    required this.floor,
    required this.isBooked,
  });
  factory HallModel.fromJson(Map<String, dynamic> json) {
    return HallModel(

      name: json['name'],
      image: json['image'],
      floor: json['floor'],
      isBooked: json['available'],
    );
  }
}
