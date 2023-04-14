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
  late String id;
  Profile ({required this.first_name, required this.last_name, required this.email, required this.phone_number,required this.id});
factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      first_name: json['first_name'],
      last_name: json['last_name'],
      email:json['email'],
      phone_number:json['phone_number'],
      id:json['id']
    );
  }
  
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
