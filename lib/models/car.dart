class Car {
  final int id;
  final String name;
  final String plateNo;
  final int currentMileage;
  final String createdAt;

  Car({
    required this.id,
    required this.name,
    required this.plateNo,
    required this.currentMileage,
    required this.createdAt,
  });

  factory Car.fromJson(Map<String, dynamic> json) {
    return Car(
      id: json['id'],
      name: json['name'],
      plateNo: json['plate_no'],
      currentMileage: json['total_mileage'],
      createdAt: json['created_at'],
    );
  }
}
