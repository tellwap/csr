class Car {
  final int id;
  final String name;
  final String plateNo;

  Car({required this.id, required this.name, required this.plateNo});

  factory Car.fromJson(Map<String, dynamic> json) {
    return Car(
      id: json['id'],
      name: json['name'],
      plateNo: json['plate_no'],
    );
  }
}
