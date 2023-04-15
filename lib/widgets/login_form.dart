// ignore_for_file: avoid_print
import 'package:checkin/screens/user_signUp.dart';
import 'package:checkin/screens/student_home.dart';
import 'package:flutter/material.dart';
 import '../utils/apis_list.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  bool _loading=false;
  late String _username = "", _password = "";
  String _errorMessage = "";
  submit() {
    setState(() {
      _errorMessage = "";
      _loading=true;
    });
    var data = {"email": "gathaiya28@gmail.com", "password": "qwertyman"};
    login(
        data,
        (result, error) => {
              if (result == null)
                {
                  setState(() {
                  _loading=false;
                }),
                  print(error),
                  setState(() {
                    _errorMessage = error;
                  })
                }
              else
                {
                    setState(() {
                  _loading=false;
                }),
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => StudentHomeScreen()),
                  )
                }
            });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            _errorMessage != ""
                ? Container(
                    height: 20,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    decoration: const BoxDecoration(),
                    padding: const EdgeInsets.all(2),
                    child: Text(
                      "$_errorMessage",
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                  )
                : Container(height: 1),
            TextFormField(
              initialValue: "gathaiya28@gmail.com",
              decoration: InputDecoration(
                  labelText: 'Username',
                 
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    gapPadding: 10.0,
                  )),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter a username';
                }
                return null;
              },
              onSaved: (value) => _username = value!,
            ),
            const SizedBox(
              height: 10.0,
            ),
            TextFormField(
              initialValue: "qwertyman",
              decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    gapPadding: 10.0,
                  )),
              obscureText: true,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter a password';
                }
                return null;
              },
              onSaved: (value) => _password = value!,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff008346),
              ),
              onPressed: () {
                submit();
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  // Use _username and _password to log in
                }
              },
              child: const Text('Log in'),
            ),
            Center(
              child: SizedBox(
                child: Column(
                  children: <Widget>[
                    const Text("DO you have an account?"),
                   Builder(
  builder: (context) => GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => UserSignUp()),
      );
    },
    child: const Text(
      "click here to register",
      style: TextStyle(color: Colors.blue),
    ),
  ),
)
                  ],
                ),
              ),
            ),
          _loading?  Center(
  child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: const [
      CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(const Color(0xff008346)), 
      ), 
      SizedBox(height: 8),
      Text(
        'Loading...',
        style: TextStyle(fontStyle: FontStyle.italic),
      ),
    ],
  ),
):Container()

          ],
        ),
      ),
    );
  }
}
