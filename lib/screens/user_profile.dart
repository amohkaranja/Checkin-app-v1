// import 'package:checkin/screens/Account_edit.dart';
// import 'package:checkin/screens/Scanned_classes.dart';
// import 'package:checkin/screens/classes.dart';
import 'package:checkin/screens/Login_page.dart';
// import 'package:checkin/screens/security.dart';
import 'package:checkin/screens/student_home.dart';
import 'package:checkin/utils/apis_list.dart';
import 'package:flutter/material.dart';

import '../models/user_model.dart';

class User_Profile extends StatefulWidget {
  const User_Profile({super.key});

  @override
  State<User_Profile> createState() => _User_ProfileState();
}

class _User_ProfileState extends State<User_Profile> {
 Profile? _profile; 
  @override
void initState() {
  super.initState();
  loadProfileData();
  }

  Future<void> loadProfileData() async {
  final profile = await profileData();
   setState(() {
      _profile = profile; // assign the value of profile to _profile
    });
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
        title: const Text(
          "My Profile",
          style: TextStyle(
              fontStyle: FontStyle.italic, fontWeight: FontWeight.w400),
        ),
        backgroundColor: const Color(0xff008346),
      ),
      body: SingleChildScrollView(
        child: Column(children:<Widget> [
           
           Container(
             
            width: double.infinity,
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0,),
                child: Container(
                  height: 140,
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: const Color(0xff008346),width: 2.0),
                      ),
                  child: const Image(
                    image: AssetImage("assets/images/logo_jpg.png"),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Center(child: Column(children:  <Widget>[
              Text(_profile?.first_name ?? '',style: TextStyle(fontWeight: FontWeight.w600,fontStyle: FontStyle.italic),),
              Text(_profile?.email?? '',style: TextStyle(fontStyle: FontStyle.italic,color: Colors.blue),),
              Text(_profile?.regNo??'',style: TextStyle(fontStyle: FontStyle.italic)),
              Text(_profile?.phone_number?? '',style: TextStyle(fontWeight: FontWeight.w300,fontStyle: FontStyle.italic)),
            ]),),
          ),
     
      Card(
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                    //       Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (context) => MyClasses()),
                    // );
                        },
                      child: Column(
                                children: const [
                                  Text("Classes Registered",style: TextStyle(color: Color(0xff008346)),),
                                  Text("2")
                                ],
                              ),
                    ),GestureDetector(
                        onTap: () {
                    //       Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (context) => ScannedClasses()),
                    // );
                        },
                      child: Column(
                                children: const [
                                  Text("Classes signed",style: TextStyle(color: Color(0xff008346))),
                                  Text("2")
                                ],
                              ),
                    )
                  ],
                  )),
        ),
      ),
      Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
            child: Row(
              children: [
                const Image(
                        image: AssetImage("assets/images/edit.png"),
                        height: 40,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0,),
                        child: GestureDetector(
                           onTap: () {
                    //       Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (context) => Account_Edit()),
                    // );
                        },
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                            Text("Account",style: TextStyle(fontWeight: FontWeight.w600),),
                            Text("Edit personal information",style: TextStyle(fontWeight: FontWeight.w300,fontStyle: FontStyle.italic))
                          ],),
                        ),
                      )
              ],
            ),
          ),
           Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
            child: GestureDetector(
                 onTap: () {
                    //       Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (context) => ChangePassword()),
                    // );
                        },
              child: Row(
                children: [
                  const Image(
                          image: AssetImage("assets/images/key.png"),
                          height: 40,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30.0,),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                            Text("Security",style: TextStyle(fontWeight: FontWeight.w600),),
                            Text("Change password",style: TextStyle(fontWeight: FontWeight.w300,fontStyle: FontStyle.italic))
                          ],),
                        )
                ],
              ),
            ),
          ), Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
            child: Row(
              children: [
                const Image(
                        image: AssetImage("assets/images/acknowledgement.png"),
                        height: 40,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0,),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                          
                          Text("Acknowledgement",style: TextStyle(fontWeight: FontWeight.w600),),
                          Text("Public testers and appreciation list",style: TextStyle(fontWeight: FontWeight.w300,fontStyle: FontStyle.italic))
                        ],),
                      )
              ],
            ),
          ),  Card(child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(children:  <Widget>[
                  Expanded(child: Center(child: Text("Check-In V 1.0"))),
                
                  GestureDetector(
                    onTap: () {
                      logout();
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
                    },
                    child: Image(image: AssetImage("assets/images/exit.png"),
                                height: 40,
                              ),
                  )],),
          )),
          
          
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0,),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: <Widget>[
                      GestureDetector(
                          onTap: () {
                          Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => StudentHomeScreen()),
                    );
                        },
                        child: Image(
                          image: AssetImage("assets/images/home.png"),
                          height: 40,
                        ),
                      ),
                      Text("Home")
                    ],
                  ),
                  Column(
                    children:  [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => User_Profile()),
                    );
                        },
                        child: const Image(
                          image: AssetImage("assets/images/account.png"),
                          height: 40,
                        ),
                      ),
                      const Text("Profile")
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      )
        ]),
      ),
    );
  }
}