import 'package:app/configuration/constraints.dart';
import 'package:app/configuration/fade_animation.dart';
import 'package:app/configuration/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// This is the login authentication page of the application.
/// This page contains the login, signup, forgot password, and google sign in buttons.
/// This is the landing page of the application when first opened.
///
/// @author [Aditya Pratap]
/// @version 1.0
class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

/// This is the statefull class and child of the LoginPage
/// This class maintains state changes that may occur.
///
/// @author [Aditya Pratap]
/// @modified []
/// @version 1.0
class _LoginPageState extends State<LoginPage> {
  // Height and width of the screen.
  double _height;
  double _width;

  final _formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    // Initialize the instance variables.
    this._height = SizeConfig.screenHeight;
    this._width = SizeConfig.screenWidth;

    return Scaffold(
      body: ListView(
        children: <Widget>[_showLogo(context), _showForm(context)],
      ),
    );
  }

  /// This method creates and displays the logo of the app on the login page.
  /// The logo contains the name of the app, a one-sentence description and LogIn text.
  ///
  /// @param [context] the BuildContext or the laocation of the widget in the tree structure.
  /// @return A new FadeAnimation widget that contains childre.
  Widget _showLogo(BuildContext context) {
    // A nice animation that slides in the logo in a second's duration.
    return FadeAnimation(
        1,
        Align(
          alignment: Alignment.topCenter,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    left: this._width * .02, top: this._height * .10),
                child: Text("Skribe",
                    style: TextStyle(
                        fontSize: this._width * .25,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Montserrat')),
              ),
              RichText(
                  text:
                      TextSpan(text: "THE ULTIMATE STUDENT PRODUCTIVITY APP")),
              SizedBox(height: this._height * .05),
              RichText(
                  text: TextSpan(
                      text: "LOG IN",
                      style: TextStyle(fontSize: this._width * .05)))
            ],
          ),
        ));
  }

  /// This method builds and returns the log in authentication form.
  /// The form contains a email address input, a password input, the log in method,
  /// and the sign up button in a column.
  ///
  /// The buttons are included in _showForm becasue the login and signup buttons
  /// are directly related to user authentication.
  ///
  /// This form will contain an form key [_formkey] that will save the fields,
  /// and submit for authentication with firebase.
  ///
  /// @param [context] the BuildContext or the laocation of the widget in the tree structure.
  /// @return A new container widget that contains children.
  Widget _showForm(BuildContext context) {
    return Container(
        padding: EdgeInsets.fromLTRB(16.0, 0, 16.0, 16.0),
        child: new Form(
          key: this._formKey,
          child: new Column(
            children: <Widget>[
              // Input fields
              _showEmailAndPasswordInputs(context),

              // Log In button
              _showLoginButton(context),

              // Sign Up  button
              _showSignUpButton(context),
            ],
          ),
        ));
  }

  /// This method builds and returns the input fields that are email address
  /// and password.
  ///
  /// The input fields are TextFormFields, that means the fields can have validators
  /// that can validate the format of the input.
  ///
  /// The passowrd field is obscured that is the text will not show to maintain privacy.
  /// Instead, a standard password hiding dots will display.
  ///
  /// @param [context] the BuildContext or the laocation of the widget in the tree structure.
  /// @return A new FadeAnimation widget that contains the input fields.
  Widget _showEmailAndPasswordInputs(BuildContext context) {
    return new FadeAnimation(
      1.5,
      Container(
        padding:
            EdgeInsets.fromLTRB(30, this._height * .02, 30, this._height * .05),
        child: Column(
          children: <Widget>[
            TextFormField(
              cursorColor: primaryColor,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: "Email Address",
                labelStyle: TextStyle(color: primaryColor),
                prefixIcon: Icon(
                  Icons.mail,
                  color: primaryColor,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white, width: 2.0),
                  borderRadius: BorderRadius.circular(25.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: primaryColor, width: 2.0),
                  borderRadius: BorderRadius.circular(25.0),
                ),
              ),
              style:
                  TextStyle(color: Colors.white, decorationColor: Colors.white),
            ),
            SizedBox(
              height: this._height * .05,
            ),
            TextFormField(
              obscureText: true,
              cursorColor: primaryColor,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: "Password",
                labelStyle: TextStyle(color: primaryColor),
                prefixIcon: Icon(
                  Icons.vpn_key,
                  color: primaryColor,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white, width: 2.0),
                  borderRadius: BorderRadius.circular(25.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: primaryColor, width: 2.0),
                  borderRadius: BorderRadius.circular(25.0),
                ),
              ),
              style:
                  TextStyle(color: Colors.white, decorationColor: Colors.white),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
                padding: EdgeInsets.only(left: this._width * .40),
                child: Text(
                  "Forgot Password?",
                  maxLines: 1,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                )),
          ],
        ),
      ),
    );
  }

  /// This method builds and returns the Log In button that authenticates
  /// a user into the app.
  ///
  /// Once clicked, the app routes to the HomePage.
  ///
  /// @param [context] the BuildContext or the laocation of the widget in the tree structure.
  /// @return A new FadeAnimation widget that contains the button.
  Widget _showLoginButton(BuildContext context) {
    return FadeAnimation(
        2,
        GestureDetector(
          onTap: () {
            // TO-DO Verify the credentials and log the user into the app.
          },
          child: Padding(
            padding: EdgeInsets.only(
                left: this._width * .05, right: this._width * .05),
            child: Container(
              height: .07 * this._height,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50), color: primaryColor),
              child: Center(
                child: Text(
                  "Login",
                  style: TextStyle(
                      color: backGroundColor,
                      fontWeight: FontWeight.bold,
                      fontSize: this._width * .07),
                ),
              ),
            ),
          ),
        ));
  }

  /// This method builds and returns the Sign Up button that registers
  /// the user to the app.
  ///
  /// Once clicked, the app routes back to the Log In page.
  ///
  /// @param [context] the BuildContext or the laocation of the widget in the tree structure.
  /// @return A new FadeAnimation widget that contains the button.
  Widget _showSignUpButton(BuildContext context) {
    return FadeAnimation(
        2,
        GestureDetector(
          onTap: () {
            // TO-DO Lead the user to the sign up page for registration.
          },
          child: Padding(
            padding: EdgeInsets.only(
                left: this._width * .05,
                right: this._width * .05,
                top: this._height * .05),
            child: Container(
              height: .07 * this._height,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.transparent,
                border: Border.all(
                    color: primaryColor, style: BorderStyle.solid, width: 2.0),
              ),
              child: Center(
                child: Text(
                  "Sign Up",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: this._width * .07),
                ),
              ),
            ),
          ),
        ));
  }
}
