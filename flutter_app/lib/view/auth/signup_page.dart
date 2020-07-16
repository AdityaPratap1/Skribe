import 'package:app/configuration/constraints.dart';
import 'package:app/configuration/fade_animation.dart';
import 'package:app/configuration/input_validator.dart';
import 'package:app/configuration/size_config.dart';
import 'package:app/services/user_authentication.dart';
import 'package:app/view_models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// This is the Sign Up registration page of the application.
/// This class contains the sign up form and the sign up button.
///
/// The user signs up using first name, last name, email address, password.
///
/// @author [Aditya Pratap]
/// @version 1.0
class SignUpPage extends StatefulWidget {
  final BaseAuth auth;
  final VoidCallback loginCallback;

  SignUpPage({Key key, @required this.auth, @required this.loginCallback})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => SignUpPageState();
}

/// This is the statefull class and child of the SignUpPage.
/// This class maintains state changes that may occur.
///
/// @author [Aditya Pratap]
/// @modified []
/// @version 1.0
class SignUpPageState extends State<SignUpPage> {
  double _height;
  double _width;

  String _errorMessage;
  bool _isLoading;

  TextEditingController _firstNameController;
  TextEditingController _lastNameController;
  TextEditingController _emailController;
  TextEditingController _passwordController;
  TextEditingController _confirmPasswordController;


  UserModel _thisUser;

  final _formKey = new GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    //executes after build is done
    this._firstNameController = new TextEditingController();
    this._lastNameController = new TextEditingController();
    this._emailController = new TextEditingController();
    this._passwordController = new TextEditingController();
    this._confirmPasswordController = new TextEditingController();


    this._thisUser = new UserModel();
  }

  @override
  Widget build(BuildContext context) {
    // Initialize instance varibales
    SizeConfig().init(context);
    this._height = SizeConfig.screenHeight;
    this._width = SizeConfig.screenWidth;

    return Scaffold(
      body: ListView(
        children: <Widget>[
          this._showBackButton(context),
          this._showSignUpText(context),
          this._showSignUpForm(context)
        ],
      ),
    );
  }

  /// This method builds the back button to navigate to the previous screen.
  ///
  /// @param [context] the BuildContext or the laocation of the widget in the tree structure.
  ///
  /// @precondition none
  /// @return A new padding containing the IconButton.
  Widget _showBackButton(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(left: this._width * .10, top: this._height * .02),
      child: Align(
        alignment: Alignment.topLeft,
        child: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: this._width * .1,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
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
            padding: EdgeInsets.only(top: this._height * .01),
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
              controller: this._firstNameController,
              validator: (value) => InputValidator.fname(value),
              style:
                  TextStyle(color: Colors.white, decorationColor: Colors.white),
              onSaved: (value) => this._firstNameController.text = value.trim(),
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
              controller: this._lastNameController,
              validator: (value) => InputValidator.lname(value),
              onSaved: (value) => this._lastNameController.text = value.trim(),
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
              controller: this._emailController,
              validator: (value) => InputValidator.email(value),
              onSaved: (value) => this._emailController.text = value.trim(),
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
              controller: this._passwordController,
              validator: (value) => InputValidator.password(value),
              onSaved: (value) => this._passwordController.text = value.trim(),
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
              controller: this._confirmPasswordController,
              validator: (value) => value != this._passwordController.text
                  ? 'Passwords do not match'
                  : null,
              onSaved: (value) =>
                  this._confirmPasswordController.text = value.trim(),
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
            this._validateAndSignUp();
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

  /// This method verifies if all the inputs for the fields have been entered appropriately,
  /// and saves the vales.
  ///
  /// @precondition none.
  /// @return A boolean indicating if all the inputs have been eneterd appropriately.
  ///
  bool _validateAndSave() {
    final form = this._formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  /// This method registers the user into the app by calling the signUp method and the logincallback method from the Auth class.
  ///
  /// @precondition none
  /// @postcondition The user is validated, registered, and signed in to the app.
  void _validateAndSignUp() async {
    if (this._validateAndSave()) {
      setState(() {
        this._errorMessage = "";
        this._isLoading = true;
      });

      try {
        this._thisUser.setUserId = await this
            .widget
            .auth
            .signUp(this._emailController.text, this._passwordController.text);

        //check if user has been successfully signed up
        if (this.widget.auth.getCurrentUser() != null) {
          //finish loading
          setState(() {
            this._isLoading = false;
          });

          //Log in
          this.widget.loginCallback();
        }
      } catch (e) {
        if (e is PlatformException) {
          // Check if the current emial already exists.
          if (e.code == 'ERROR_EMAIL_ALREADY_IN_USE') {
            // If email already exists, warn user using an alert dialog from the GeneralWidgets class.
          }
        }
        setState(() {
          this._isLoading = false;
          this._errorMessage = e.message;
          this._formKey.currentState.reset();
        });
      }
    }
  }
}
