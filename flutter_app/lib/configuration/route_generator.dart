import 'package:app/view/home/home_page.dart';
import 'package:app/view/auth/login_page.dart';
import 'package:app/view/auth/root_page.dart';
import 'package:app/view/auth/signup_page.dart';
import 'package:app/view/home/task_page.dart';
import 'package:flutter/material.dart';

/// This class managaes the routing for the app.
/// All the routes are encapsulated in this class to make it
/// more efficient to route.
///
/// All mentions of the MaterialPageRoute are only mentioned here and
/// nowhere in the app.
///
/// To access a route from this class, one has to call Navigator.pushNamed()
/// The pushNamed() maethod takes a the name of the route such as
/// Navigator.of(context).pushNamed('/login);
///
/// Passing multiple paramaeters is only possible through a map since the constructors
/// only take 1 parameter.
///
/// @author [Aditya Pratap]
/// @version 1.0
///
class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final _args = settings.arguments as Map;

    // settings.name contains the name(path) of the route.
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => RootPage());

      case '/login':
        return MaterialPageRoute(builder: (_) => LoginPage());

      case '/signup':
        return MaterialPageRoute(
            builder: (_) => SignUpPage(
                  loginCallback: _args['loginCallback'],
                  auth: _args['auth'],
                ));

      case '/home':
        return MaterialPageRoute(
            builder: (_) => HomePage(
                  thisUser: _args['thisUser'],
                ));
      case '/tasks':
        return MaterialPageRoute(builder: (_) => TaskPage(notebookDocId: _args['notebookDocId'],));

      default:
        return null;
    }
  }
}
