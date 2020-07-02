import 'package:app/models/user.dart';
import 'package:app/services/user_authentication.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class HomePage extends StatefulWidget {
  User thisUser;
  BaseAuth auth;
  HomePage({this.thisUser});
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  BaseAuth _auth = new Auth();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: () {
            this._auth.signOut();
            RestartWidget.restartApp(context);
          },
          child: Text(widget.thisUser.getUserId,
              style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}
