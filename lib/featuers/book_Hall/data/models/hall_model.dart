class HallModel {
  final String name;
  final String image;
  final String floor;
  final bool isBooked;
  final int reversationsCount;
  //  set reservationsCount(int value) {
  //   if (value <=0 ) {
  //     _reversationsCount=value; 
  //   }
  //  }
  // int get reservationsCount => _reversationsCount;
  HallModel({
    required this.reversationsCount,
    required this.name,
    required this.image,
    required this.floor,
    required this.isBooked,
  });
  factory HallModel.fromJson(Map<String, dynamic> json,int count) {
    return HallModel(
      reversationsCount: count,
      name: json['name'],
      image: json['image'],
      floor: json['floor'],
      isBooked: json['available'],
    );
  }
}
