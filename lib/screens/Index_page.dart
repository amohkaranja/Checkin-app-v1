import 'Login_page.dart';
import 'package:flutter/material.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({super.key});

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  bool _loading=true;
  @override
  void initState() {
    super.initState();
    fetchData();
  }
   void callMain() async{
           Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HomeScreen()),
                  );
        
         }
    void fetchData() async {
    
    setState(() {
      _loading = false;
      callMain();
    });
   
  }
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Colors.white,
      body:  Stack(
        
        children: <Widget>[
              Positioned(
                left: 0,
              bottom: 15,
              right: 0,
                child: Column(children:  <Widget>[
                  const Image(
                          image: AssetImage("assets/images/logo_jpg.png"),
                          height: 200,
                          width: 200,
                        ),
             const Text("v 2.0"),
             _loading?  Center(
              child: Column(mainAxisAlignment: MainAxisAlignment.center,
    children: const [
      CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(const Color(0xff008346)), 
      ), 
      SizedBox(height: 8),
     
    ],),
             ):Container()
                ]),
               ), 
        ],
      ),
    );
  }
}