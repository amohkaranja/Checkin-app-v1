import 'package:checkin/widgets/login_form.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final String password = "";
  final String email = "";

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: const Color(0xff008346),
            elevation: 0.0,
          ),
          backgroundColor: Colors.white,
          body: Column(
            children: <Widget>[
              Container(
                height: 10.0,
                decoration: const BoxDecoration(color: Colors.white),
              ),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(color: Colors.white),
                  child: Expanded(
                    child: Column(children: <Widget>[
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          // ignore: prefer_const_literals_to_create_immutables
                          children: <Widget>[
                            const SizedBox(
                              height: 200.0,
                              width: 250.0,
                              child: Image(
                                  image: AssetImage("assets/images/logo.png")),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Expanded(
                        child: Container(
                          // height: 200.0
                          width: 400.0,
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: LoginForm(),
                        ),
                      ),
                    ]),
                  ),
                ),
              )
            ],
          )),
    );
  }
}
