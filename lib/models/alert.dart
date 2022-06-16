class Alert {
  final int id;
  final int distance;
  final int time;

  Alert({required this.id, required this.distance, required this.time});

  factory Alert.fromJson(Map<String, dynamic> json) {
    return Alert(
      id: json['id'],
      distance: json['distance'],
      time: json['speed'],
    );
  }
}
