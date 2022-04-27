class User {
  final int id;
 final String phoneNumber;
 final String firstName;
  final String lastName;
  final String email;


  User({required this.id, required this.phoneNumber,required this.firstName, required this.lastName,required this.email});

  //function to convert json data to user object/model
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'],
        phoneNumber: json['phone_number'],
        firstName: json['first_name'],
        lastName: json['last_name'],
        email: json['email'],
    );
  }
}
