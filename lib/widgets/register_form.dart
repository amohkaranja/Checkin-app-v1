// import 'dart:html';

import 'package:flutter/material.dart';
import '../utils/apis_list.dart';
import '../screens/Login_page.dart';
import 'package:intl/intl.dart';
import 'inputs.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserRegister extends StatefulWidget {
  const UserRegister({super.key});

  @override
  State<UserRegister> createState() => _UserRegisterState();
}

class _UserRegisterState extends State<UserRegister> {
  final _formKey = GlobalKey<FormState>();
@override
void initState() {
    dateInput.text = ""; //set the initial value of text field
    super.initState();
    fetchInstitutions();
  }

  final TextEditingController _emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
   List<String> _institutions = []; // list of institutions
  late String? _selectedId = _institutions[0].split(":")[1]; // selected institution ID
 
  // fetch institutions from URL

   
  Future<void> fetchInstitutions() async {

      final prefs = await SharedPreferences.getInstance();
     _institutions= (prefs.getStringList("schools")??[]);

   
  }

  bool _isEmailValid = true;
  bool _isFirstName = false;
  bool _isLastName = false;
  bool _isOtherNames = false;
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
      middle_name = "",
      _confirmPassword = "",
      student_number = "";
  String _errorMessage = "";
  final List<String> titles = <String>['Mr', 'Mrs', 'Miss', 'Dr', 'Prof'];
  final List<String> genders = <String>['MALE', 'FEMALE', 'OTHERS'];
  late String title = titles.first;
  late String gender = genders.first;
  bool _obscureText = true;

  submit() {
    setState(() {
      _errorMessage = "";
    });
    var data = {
      "first_name": first_name,
      "last_name": last_name,
      "other_names": middle_name,
      "title": title,
      "email": email,
      "password": _password,
      "gender": gender,
      "phone_number": "+254$_phoneNumber",
      "user_type": "STUDENT",
      "student_number": student_number,
      "institution_id": _selectedId,
      "date_of_birth": DateTime.parse(dateInput.text).toUtc().toIso8601String()
    };
    if (_isFirstName &&
        _isLastName &&
        _isOtherNames &&
        _isPhoneNumber &&
        _isRegNo &&
        _isPassword) {
      print(data);
      post(
          data,
          "api/auth/users/",
          (result, error) => {
                if (result == null)
                  {
                    print("wueeh, kuna errors huku${error}"),
                    setState(() {
                      _errorMessage = error;
                    })
                  }
                else
                  print("It's a good day, no errors"),
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                )
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
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 3),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: DropdownButton<String>(
              isExpanded: true,
              value: title, // Set the selected value
              onChanged: (String? value) {
                // This is called when the user selects an item.
                setState(() {
                  title = value!;
                });
              },
              items: titles.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          CustomTextField(labelText: 'First Name', validator: (value) {
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
              return '';
            }, onSaved: (value) => first_name = value!),
      
          const SizedBox(
            height: 10.0,
          ),
          CustomTextField(
            labelText:"Last Name" ,
            onSaved: (value) => last_name = value!,
            validator:(value) {
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
              return '';
            }, 
            
          ),
    
          const SizedBox(
            height: 10.0,
          ),
         CustomTextField(
          labelText: "Middle Name",
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter middle name';
                    } else {
                      return '';
                    }
                  },
                  onSaved: (value) => middle_name = value!,
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
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 3),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: DropdownButton<String>(
              isExpanded: true,
              value: gender, // Set the selected value
              onChanged: (String? value) {
                // This is called when the user selects an item.
                setState(() {
                  gender = value!;
                });
              },
              items: genders.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          Container(
              // padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(5.0),
              ),
              // height: MediaQuery.of(context).size.width / 3,
              child: Center(
                  child: TextField(
                controller: dateInput,
                //editing controller of this TextField
                decoration: const InputDecoration(
                    icon: Icon(Icons.calendar_today), //icon of text field
                    labelText: "Date of birth" //label text of field
                    ),
                readOnly: true,
                //set it true, so that user will not able to edit text
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1950),
                      //DateTime.now() - not to allow to choose before today.
                      lastDate: DateTime(2100));

                  if (pickedDate != null) {
                    print(
                        pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                    String formattedDate =
                        DateFormat('yyyy-MM-dd').format(pickedDate);
                    print(
                        formattedDate); //formatted date output using intl package =>  2021-03-16
                    setState(() {
                      dateInput.text =
                          formattedDate; //set output date to TextField value.
                    });
                  } else {}
                },
              ))),
          const SizedBox(
            height: 10.0,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 3),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: _institutions.isNotEmpty
                ? DropdownButton(
                    isExpanded: true,
                    value: _selectedId,
                    hint: const Text('Select an institution'),
                    items: _institutions.map((university) {
                      final splitUniversity = university.split(":");
                      return DropdownMenuItem(
                         value: splitUniversity[1],
                         child: Text(splitUniversity[0]),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedId = value.toString();
                      });
                    },
                  )
                : Loading(),
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
                return isPasswordValid(value);
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
