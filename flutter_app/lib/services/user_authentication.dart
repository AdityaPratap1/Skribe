import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';

abstract class BaseAuth {
  /// This firebase method signs the user into the app.
  ///
  /// @param [email] The email address part of the credentials.
  /// @param [password] The password part of the credentials
  ///
  /// @precondition The email address cannot be null or empty.
  /// @precondition The password cannot be null or empty.
  /// @return The userId of the signed in user.
  Future<String> signIn(String email, String password);

  /// This firebase method registers the user into the app.
  ///
  /// @param [email] The email address part of the credentials.
  /// @param [password] The password part of the credentials
  ///
  /// @precondition The email address cannot be null or empty.
  /// @precondition The password cannot be null or empty.
  /// @return The userId of the signed up user.
  Future<String> signUp(String email, String password);

  /// This firebase method that gets the current user logged into the app.
  ///
  /// @return The FirebaseUser logged into the app.
  Future<FirebaseUser> getCurrentUser();

  /// This firebase method sends the email verification link to the
  /// current user's eneterd email address.
  ///
  /// @precondition none
  /// @return none
  Future<void> sendEmailVerification();

  /// This firebase method logs the current user out of the app.
  ///
  /// @precondition none
  /// @postcondition  The user has been signed out of the app.
  Future<void> signOut();

  /// This firebase method checks if a user's email has been verified.
  ///
  /// @precondition none
  /// @return  A boolean indicating if the current user's email has been verified.
  Future<bool> isEmailVerified();

  /// This firebase method sends the password reset link to the
  /// current user's eneterd email address.
  ///
  /// @param [userEmail] The email address to which the reset link to be sent to.
  ///
  /// @precondition The email address cannot be null or empty.
  /// @return none
  Future<void> sendPasswordResetEmail(String email);
}

class Auth extends BaseAuth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // Sign in user using email and password.
  @override
  Future<String> signIn(String email, String password) async {
    if (email.isEmpty || email == null) {
      throw new ArgumentError("The email address cannot be null or empty");
    }

    if (password.isEmpty || password == null) {
      throw new ArgumentError("The password cannot be null or empty");
    }
    AuthResult result = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    FirebaseUser user = result.user;
    return user.uid;
  }

  // Sign up user using email and password. A new user is created if the method executes properly.
  @override
  Future<String> signUp(String email, String password) async {
    if (email.isEmpty || email == null) {
      throw new ArgumentError("The email address cannot be null or empty");
    }

    if (password.isEmpty || password == null) {
      throw new ArgumentError("The password cannot be null or empty");
    }
    AuthResult result = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    FirebaseUser user = result.user;
    return user.uid;
  }

  @override
  Future<FirebaseUser> getCurrentUser() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    //await user.reload();
    return user;
  }

  @override
  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }

  // This method sends a verification email to the user. A user cannot login until email is verified.
  @override
  Future<void> sendEmailVerification() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    user.sendEmailVerification();
  }

  // Check if user verified their email
  @override
  Future<bool> isEmailVerified() async {
    print("checking user verification...");
    FirebaseUser user = await _firebaseAuth.currentUser();
    print("received result: ${user.isEmailVerified}");
    return user.isEmailVerified;
  }

  @override
  Future<void> sendPasswordResetEmail(String email) async {
    if (email.isEmpty || email == null) {
      throw new ArgumentError("The email address cannot be null or empty");
    }
    _firebaseAuth.sendPasswordResetEmail(email: email);
  }
}
