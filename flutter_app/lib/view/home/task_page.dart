import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TaskPage extends StatelessWidget {
   @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
            child: Text("This is the Task Page", style: TextStyle(color: Colors.white))),
      ),
    );
  }
}