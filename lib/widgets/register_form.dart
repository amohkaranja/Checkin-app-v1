// import 'dart:html';

import 'package:flutter/material.dart';
import '../utils/apis_list.dart';
import '../screens/Login_page.dart';
import 'inputs.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserRegister extends StatefulWidget {
  const UserRegister({super.key});

  @override
  State<UserRegister> createState() => _UserRegisterState();
}

class _UserRegisterState extends State<UserRegister> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
 

  bool _isEmailValid = true;
  bool _isFirstName = false;
  bool _isLastName = false;
  bool _isPhoneNumber = false;
  bool _isRegNo = false;
  bool _isPassword = false;
  bool _validateEmail(String email) {
    String emailPattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    RegExp regExp = RegExp(emailPattern);
    return regExp.hasMatch(email);
  }

  bool validatePhone(String phone) {
    // Regular expression pattern to match a 9-digit phone number that doesn't start with 0
    RegExp pattern = RegExp(r'^[1-9]\d{8}$');
    return pattern.hasMatch(phone);
  }

  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool validatePassword() {
    if (_password == _confirmPassword) {
      return true;
    } else {
      return false;
    }
  }

  late String _username = "",
      _password = "",
      first_name = "",
      last_name = "",
      email = "",
      _phoneNumber = "",
      _confirmPassword = "",
      student_number = "";
  String _errorMessage = "";
  bool _obscureText = true;

  submit() {
    setState(() {
      _errorMessage = "";
    });
    var data = {
      "firstname": first_name,
      "lastname": last_name,
      "email": email,
      "password": _password,
      "phone": "+254$_phoneNumber",
      "regNo": student_number,
    };
    if (_isFirstName &&
        _isLastName &&
        _isPhoneNumber &&
        _isRegNo &&
        _isPassword) {
      print(data);
      post(
          data,
          "student_register.php",
          (result, error) => {
                if (result == null)
                  {
                    setState(() {
                      _errorMessage = error;
                    }),
                    
                    
                  }
                else{
                  print("It's a good day, no errors"),
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                )}
              });
    }
  }

  TextEditingController dateInput = TextEditingController();
  
  String validateInput(String? value, bool stateVariable, void Function(bool) setStateVariable) {
  if (value!.isEmpty) {
    setStateVariable(false);
    return 'Please enter a value';
  } else {
    setStateVariable(true);
    return '';
  }
}
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
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
                    _errorMessage,
                    style: const TextStyle(
                        color: Colors.red,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                )
              : Container(height: 1),
        
          const SizedBox(
            height: 10.0,
          ),
                   TextFormField(
            decoration: InputDecoration(
                labelText: 'First Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  gapPadding: 5.0,
                )),
            keyboardType: TextInputType.phone,
            onChanged: (value) {
              // Validate the phone number as the user types
              if (!validatePhone(value)) {
                phoneController.clear();
              }
            },
            validator: (value) {
              if (value!.isEmpty) {
                setState(() {
                  _isFirstName = false;
                });

                return 'Please enter first name';
              } else {
                setState(() {
                  _isFirstName = true;
                });
              }
              return null;
            },
            onSaved: (value) => first_name = value!
          ),    
      
          const SizedBox(
            height: 10.0,
          ),
                    TextFormField(
            decoration: InputDecoration(
                labelText: "Last Name" ,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  gapPadding: 5.0,
                )),
            keyboardType: TextInputType.phone,
            onChanged: (value) {
              // Validate the phone number as the user types
              if (!validatePhone(value)) {
                phoneController.clear();
              }
            },
            validator: (value) {
               if (value!.isEmpty) {
                setState(() {
                  _isLastName = false;
                });
                return 'Please enter last name';
              } else {
                setState(() {
                  _isLastName = true;
                });
              }
              return null;
            },
            onSaved: (value) => last_name = value!,
          ),
          const SizedBox(
            height: 10.0,
          ),
          TextFormField(
            decoration: InputDecoration(
                labelText: 'Email',
                errorText:
                    _isEmailValid ? null : 'Please enter a valid email address',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  gapPadding: 5.0,
                )),
            controller: _emailController,
            onChanged: (text) {
              setState(() {
                _isEmailValid = _validateEmail(text);
              });
            },
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter email';
              }
              return null;
            },
            onSaved: (value) => email = value!,
          ),
          const SizedBox(
            height: 10.0,
          ),
          TextFormField(
            decoration: InputDecoration(
                labelText: 'Phone Number',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  gapPadding: 5.0,
                )),
            keyboardType: TextInputType.phone,
            onChanged: (value) {
              // Validate the phone number as the user types
              if (!validatePhone(value)) {
                phoneController.clear();
              }
            },
            validator: (value) {
              if (value!.isEmpty) {
                setState(() {
                  _isPhoneNumber = false;
                });
                return 'Please enter phone number';
              } else {
                setState(() {
                  _isPhoneNumber = true;
                });
              }
              return null;
            },
            onSaved: (value) => _phoneNumber = value!,
          ),
  
          const SizedBox(
            height: 10.0,
          ),
          TextFormField(
            decoration: InputDecoration(
                labelText: 'Registration Number',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  gapPadding: 5.0,
                )),
            validator: (value) {
              if (value!.isEmpty) {
                setState(() {
                  _isRegNo = false;
                });
                return 'Please enter registration number';
              } else {
                setState(() {
                  _isRegNo = true;
                });
              }
              return null;
            },
            onSaved: (value) => student_number = value!,
            onChanged: (value) {
              setState(() {
                student_number = value;
              });
            },
          ),
          const SizedBox(
            height: 10.0,
          ),
          TextFormField(
            obscureText: true,
            controller: passwordController,
            decoration: InputDecoration(
              labelText: 'Password',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                gapPadding: 5.0,
              ),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                setState(() {
                  _isPassword = false;
                });
                return 'Please enter a password';
              } else {
                setState(() {
                  _isPassword = true;
                });
                if(isPasswordValid(value)==''){
                  return null;
                }else{
                  return isPasswordValid(value);
                }
               
              }
            },
            onSaved: (value) => _password = value!,
            onChanged: (value) {
              setState(() {
                _password = value;
              });
            },
          ),
          const SizedBox(
            height: 10.0,
          ),
          TextFormField(
            controller: confirmPasswordController,
            decoration: InputDecoration(
                labelText: 'confirm password',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  gapPadding: 10.0,
                )),
            obscureText: true,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter confirm password';
              } else {
                if (value != _password) {
                  return 'password does not match';
                }
              }

              return null;
            },
            onEditingComplete: () {
              _confirmPassword = confirmPasswordController.text;
              if (!validatePassword()) {
                // Show an error message or perform some other action
              }
            },
            onSaved: (value) => _confirmPassword = value!,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xff008346),
            ),
            onPressed: () {
              
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                submit();
                // Use _username and _password to log in
              }
            },
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }
}

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: const Color.fromARGB(255, 11, 239, 129).withOpacity(0.5),
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ],
    );
  }
}
