import 'package:flutter/material.dart';
import 'package:to_do/layout/to%20do%20layout.dart';

class todoSplash extends StatelessWidget {
  const todoSplash({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    new Future.delayed(
      const Duration(seconds: 4),
        ()=>Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>todolayout())
        ),
    );
    return Scaffold(
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Todo List",style: TextStyle(color: Colors.lightBlue,fontWeight: FontWeight.bold,fontSize: 40),),
              Image.asset("images/todoo.jpg"),
            ],
          ),
    );
  }
}
