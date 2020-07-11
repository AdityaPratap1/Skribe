import 'package:app/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UpdateUserInfoFireStore {
  final _db = Firestore.instance;

  void createUser(User theUser) {
    Map<String, Object> userInfo = {
      'firstname': theUser.getFirstName,
      'lastname': theUser.getLastName,
    };
    this._db.collection('users').document(theUser.getUserId).setData(userInfo);
  }

  Stream<QuerySnapshot> getAllUserNames() {
    return _db.collection('users').snapshots();
  }
}
