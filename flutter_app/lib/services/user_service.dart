import 'package:app/view_models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/// This class handles the backend of the user attributes.
///
/// @author [Aditya Pratap]
/// @version 1.0
class UserService {
  final _db = Firestore.instance;

  /// This method creates a user in the user collection firestore.
  ///
  /// @param [theUser] A user object: the user to be created.
  ///
  /// @precondition The [theUser] cannot be null.
  /// @postcondition A new user is created in firestore.
  void createUser(UserModel theUser) {
    if (theUser == null) {
      throw new ArgumentError("The user object cannot be null");
    }
    Map<String, Object> userInfo = {
      'firstname': theUser.getFirstName,
      'lastname': theUser.getLastName,
    };
    this._db.collection('users').document(theUser.getUserId).setData(userInfo);
  }
}
