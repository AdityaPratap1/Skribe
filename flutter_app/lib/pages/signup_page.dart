import 'package:app/configuration/constraints.dart';
import 'package:app/configuration/fade_animation.dart';
import 'package:app/configuration/size_config.dart';
import 'package:app/pages/login_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// This is the Sign Up registration page of the application.
/// This class contains the sign up form and the sign up button.
///
/// The user signs up using first name, last name, email address, password.
///
/// @author [Aditya Pratap]
/// @version 1.0
class SignUpPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SignUpPageState();
}

/// This is the statefull class and child of the SignUpPage.
/// This class maintains state changes that may occur.
///
/// @author [Aditya Pratap]
/// @modified []
/// @version 1.0
class _SignUpPageState extends State<SignUpPage> {
  double _height;
  double _width;

  final _formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Initialize instance varibales
    SizeConfig().init(context);
    this._height = SizeConfig.screenHeight;
    this._width = SizeConfig.screenWidth;

    return Scaffold(
      body: ListView(
        children: <Widget>[
          this._showSignUpText(context),
          this._showSignUpForm(context)
        ],
      ),
    );
  }

  /// This method creates and displays the 'Sign Up' text on the Sign Up page.
  ///
  /// @param [context] the BuildContext or the laocation of the widget in the tree structure.
  /// @return A new FadeAnimation widget that contains children.
  Widget _showSignUpText(BuildContext context) {
    // A neat fade in animation af all the contained children.
    return FadeAnimation(
        1,
        Align(
          alignment: Alignment.center,
          child: Padding(
            padding: EdgeInsets.only(top: this._height * .10),
            child: Text(
              'Sign Up',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: this._width * .15,
                  fontFamily: 'Montserrat'),
            ),
          ),
        ));
  }

  /// This method builds and returns the sign up registration form.
  /// The form contains a first name, last name, email address, password, and
  /// a confirm password text fields. Additionally, the page also contains a
  /// sign up button.
  ///
  /// The buttons are included in _showForm becasue the signup button
  /// is directly related to user registration.
  ///
  /// This form will contain an form key [_formkey] that will save the fields,
  /// and submit for authentication with firebase.
  ///
  /// @param [context] the BuildContext or the laocation of the widget in the tree structure.
  /// @return A new container widget that contains children.
  _showSignUpForm(BuildContext context) {
    return Container(
        padding: EdgeInsets.fromLTRB(16.0, 0, 16.0, 16.0),
        child: new Form(
          key: this._formKey,
          child: new Column(
            children: <Widget>[
              this._showFirstAndLastNameInputs(context),
              // Input fields
              this._showEmailAndPasswordInputs(context),
              // Sign Up  button
              this._showSignUpButton(context),
            ],
          ),
        ));
  }

  /// This method builds and returns the input fields that are first name and last name.
  ///
  /// The input fields are TextFormFields, that means the fields can have validators
  /// that can validate the format of the input.
  ///
  /// @param [context] the BuildContext or the laocation of the widget in the tree structure.
  /// @return A new FadeAnimation widget that contains the input fields.
  Widget _showFirstAndLastNameInputs(BuildContext context) {
    return new FadeAnimation(
      1.5,
      Container(
        padding:
            EdgeInsets.fromLTRB(30, this._height * .05, 30, this._height * .05),
        child: Column(
          children: <Widget>[
            TextFormField(
              cursorColor: primaryColor,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                labelText: "First Name",
                labelStyle: TextStyle(color: primaryColor),
                prefixIcon: Icon(
                  Icons.person,
                  color: primaryColor,
                ),
                enabledBorder: UnderlineInputBorder(
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
              cursorColor: primaryColor,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                labelText: "Last Name",
                labelStyle: TextStyle(color: primaryColor),
                prefixIcon: Icon(
                  Icons.person,
                  color: primaryColor,
                ),
                enabledBorder: UnderlineInputBorder(
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
          ],
        ),
      ),
    );
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
  /// The confirm password textfield checks for equality with the passsword field to make
  /// sure the user entered an intnded password.
  ///
  /// @param [context] the BuildContext or the laocation of the widget in the tree structure.
  /// @return A new FadeAnimation widget that contains the input fields.
  Widget _showEmailAndPasswordInputs(BuildContext context) {
    return new FadeAnimation(
      1.5,
      Container(
        padding: EdgeInsets.fromLTRB(30, 0, 30, this._height * .05),
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
                enabledBorder: UnderlineInputBorder(
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
                enabledBorder: UnderlineInputBorder(
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
                labelText: "Confirm Password",
                labelStyle: TextStyle(color: primaryColor),
                prefixIcon: Icon(
                  Icons.vpn_key,
                  color: primaryColor,
                ),
                enabledBorder: UnderlineInputBorder(
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
          ],
        ),
      ),
    );
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
            Navigator.push(context,
                new MaterialPageRoute(builder: (context) => LoginPage()));
          },
          child: Padding(
            padding: EdgeInsets.only(
                left: this._width * .05,
                right: this._width * .05,
                top: this._height * .01),
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
