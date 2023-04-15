import 'package:flutter/material.dart';

class ScanClass extends StatefulWidget {
  const ScanClass({super.key});

  @override
  State<ScanClass> createState() => _ScanClassState();
}

class _ScanClassState extends State<ScanClass> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        title: const Text(
          "Scan Class",
          style: TextStyle(
              fontStyle: FontStyle.italic, fontWeight: FontWeight.w400),
        ),
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
                  height:120,
                  image: AssetImage("assets/images/logo_jpg.png"),
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ]),
      )
    );
  }
}