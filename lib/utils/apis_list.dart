import 'dart:convert';
import 'package:checkin/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';



const api = "http://admin.check-in.co.ke:71/";
// ignore: non_constant_identifier_names
/// login function
/// @param {JSON} data
/// @param{(error:JSON,result:JSON)} callback
void login(data, callback) async {
  var url = Uri.parse("${api}student_login.php");
  var response = await http.post(url, body: data);
  var jsonResponse = convert.jsonDecode(response.body) as Map<String, dynamic>;

  // ignore: avoid_print
  if (jsonResponse["success"] == "2") {
     final prefs = await SharedPreferences.getInstance();
    prefs.setString('student_id', jsonResponse['login'][0]['student_id']);
    prefs.setString('firstname', jsonResponse['login'][0]['firstname']);
    prefs.setString('lastname', jsonResponse['login'][0]['lastname']);
    prefs.setString('email', jsonResponse['login'][0]['email']);
    prefs.setString('phone', jsonResponse['login'][0]['phone']);
    prefs.setString('regNo', jsonResponse['login'][0]['regNo']);
    prefs.setString('student_profile', jsonResponse['login'][0]['student_profile']);
    prefs.setString('email_validation', jsonResponse['login'][0]['email_validation']);
        // ignore: void_checks
    return callback(jsonResponse["message"], null);
  }else{
    callback(null, jsonResponse["message"]);
  }
  
}
void logout() async{
   print("logout");
}


Future<Profile> profileData() async {
  var profile= Profile();
   final prefs = await SharedPreferences.getInstance();
  profile.id= prefs.getString('student_id')!;
  profile.first_name = prefs.getString('firstname')!;
  profile.last_name= prefs.getString('lastname')!;
 profile.email= prefs.getString('email')!;
  profile.phone_number = prefs.getString('phone')!;
  profile.regNo = prefs.getString('regNo')!;
  profile.student_profile = prefs.getString('student_profile')!;
  String? emailValidation = prefs.getString('email_validation');
    return profile;

}
Future<bool> fetchDataAndSaveToPrefs() async {
  bool loading = true;
  // obtain shared preferences
  final prefs = await SharedPreferences.getInstance();
  String url = '${api}api/v1/institution/institutions/'; 
  var response = await http.get(Uri.parse(url));
  var data = json.decode(response.body);
  // Convert data to List<String>
  List<String> schools = [];
  if (data is List) {
    schools = List.castFrom(data);
  } else if (data is Map) {
  if (data != null && data["items"] != null) {
  data["items"].forEach((item) {
    schools.add("${item['institution_name']}:${item['id']}");
  });


}

  }
  // set value
  await prefs.setStringList("schools", schools);
  loading = false;
  
  return loading;
}


void post(dynamic data, String url, Function callback) async {
   final prefs = await SharedPreferences.getInstance();
     var token= (prefs.getString("token"));
  var apiUrl = Uri.parse(api + url);
  var response = await http.post(apiUrl,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization':'Bearer ${token!}',
      },
      body: jsonEncode(data));

  var jsonResponse = convert.jsonDecode(response.body) as Map<String, dynamic>;
  if (response.statusCode == 201) {
    // ignore: void_checks
    return callback("success", null);
  }
  callback(null, jsonResponse["message"]);
}
void Patch(dynamic data, String url, Function callback) async {
   final prefs = await SharedPreferences.getInstance();
     var token= (prefs.getString("token"));
  var apiUrl = Uri.parse(api + url);
  var response = await http.patch(apiUrl,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization':'Bearer ${token!}',
      },
      body: jsonEncode(data));

  var jsonResponse = convert.jsonDecode(response.body) as Map<String, dynamic>;
  if (response.statusCode == 200) {
    // ignore: void_checks
    return callback("success", null);
  }
  callback(null, jsonResponse["message"]);
}
void get(String url,Function callback) async{
 final prefs = await SharedPreferences.getInstance();
     var token= (prefs.getString("token"));
  var url = Uri.parse("${api}api/auth/users/me"); 
    var response=  await http.get(url,headers:  <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization':'Bearer ${token!}',
      },);
  // print(response);
  var jsonResponse = convert.jsonDecode(response.body) as Map<String, dynamic>;
  // ignore: avoid_print
  if (response.statusCode == 200) {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("token",jsonResponse["access"]);
    // ignore: void_checks
    return callback(jsonResponse["message"], null);
  }
  callback(null, jsonResponse["message"]);
}

String  isPasswordValid(String password) {
    // Check if password is at least 8 characters long
    if (password.length < 8) {
      return "password must be at least 8 characters long";
    }

    // Check if password contains at least one special character
    RegExp specialCharRegex = RegExp(r'[!@#\$&\*~-]');
    if (!specialCharRegex.hasMatch(password)) {
      return "password must contains at least one special character";
    }

    // Check if password contains at least two digits
    RegExp digitRegex = RegExp(r'\d.*\d');
    if (!digitRegex.hasMatch(password)) {
      return "password must contains at least two digits";
    }

    // Check if password contains at least one uppercase letter
    RegExp upperCaseRegex = RegExp(r'[A-Z]');
    if (!upperCaseRegex.hasMatch(password)) {
      return "password must contains at least one uppercase letter";
    }

    // Check if password contains at least one lowercase letter
    RegExp lowerCaseRegex = RegExp(r'[a-z]');
    if (!lowerCaseRegex.hasMatch(password)) {
      return "password must contains at least one lowercase letter";
    }

    // If all conditions are met, return true
          return "";

  }
