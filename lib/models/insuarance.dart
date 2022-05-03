class Insuarance {
  final String name;
  final DateTime expireDate;

  Insuarance({required this.name, required this.expireDate});

  factory Insuarance.fromJson(Map<String, dynamic> json) {
    return Insuarance(
        name: json['name'], expireDate: DateTime.parse(json['expire_date']));
  }
}
