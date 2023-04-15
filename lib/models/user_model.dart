import 'dart:convert'; // to parse JSON

class User {
  final String password;
  final String email;

  User(this.password, this.email);
}

class Profile{
  late String first_name;
  late String  last_name;
  late String email;
  late String phone_number;
  late String regNo;
  late String id;
  late String student_profile;
}

class Institution {
  String id;
  String name;

  Institution({required this.id, required this.name});

  factory Institution.fromJson(Map<String, dynamic> json) {
    return Institution(
      id: json['id'],
      name: json['institution_name'],
    );
  }
}
