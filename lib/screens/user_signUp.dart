import 'package:flutter/material.dart';
import 'package:checkin/widgets/register_form.dart';

class UserSignUp extends StatefulWidget {
  const UserSignUp({super.key});

  @override
  State<UserSignUp> createState() => _UserSignUpState();
}

class _UserSignUpState extends State<UserSignUp> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User Sign Up"),
        backgroundColor: const Color(0xff008346),
      ),
      body: SingleChildScrollView(
        child: Column(children: <Widget>[
          Container(
            width: double.infinity,
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              child: Container(
                height: 140,
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.white,
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3))
                    ]),
                child: const Image(
                  image: AssetImage("assets/images/logo_jpg.png"),
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          SizedBox(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Center(
                child: Text(
                  "fill the form to register",
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
          ),
          Container(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: UserRegister())
        ]),
      ),
    );
  }
}
