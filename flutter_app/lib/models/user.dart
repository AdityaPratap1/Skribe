/// This model class keeps track of the User's attributes.
///
/// @author [Aditya Pratap]
/// @version 1.0
class User {
  String _firstName;
  String _lastName;
  String _userId;

  /// This 3-parameter optional named prameters constructors initializes the instance variables.
  ///
  /// @param [_firstName] The first name of the current user.
  /// @param [_lastName] The last name of the current user.
  /// @param [_userId] The firebase user id of the current user.
  ///
  /// @precondition The parameters cannot be null or empty.
  /// @postcondition A new User object with initialized values.
  User([this._firstName, this._lastName, this._userId]);

  /// This setter method sets the firstName instance variable with
  /// the specified value.
  ///
  /// @param [fname] The first name to be set.
  ///
  /// @precondition The parameter cannot be null or empty.
  /// @postcondition The [_firstName] instance variable is assigned.
  set setFirstName(String fname) {
    if (fname.isEmpty || fname == null) {
      throw new ArgumentError("The first name cannot be null or empty");
    }
    this._firstName = fname;
  }

  /// This getter method gets the first name of the current user.
  ///
  /// @precondition none
  /// @return The first name of the current user.
  get getFirstName {
    return this._firstName;
  }

  /// This setter method sets the lastName instance variable with
  /// the specified value.
  ///
  /// @param [lname] The last name to be set.
  ///
  /// @precondition The parameter cannot be null or empty.
  /// @postcondition The [_lastName] instance variable is assigned.
  ///
  set setLastName(String lname) {
    if (lname.isEmpty || lname == null) {
      throw new ArgumentError("The last name cannot be null or empty");
    }
    this._lastName = lname;
  }

  /// This getter method gets the last name of the current user.
  ///
  /// @precondition none
  /// @return The last name of the current user.
  get getLastName {
    return this._lastName;
  }

  /// This setter method sets the userId instance variable with
  /// the specified value.
  ///
  /// @param [uId] The user id to be set.
  ///
  /// @precondition The parameter cannot be null or empty.
  /// @postcondition The [_userId] instance variable is assigned.
  set setUserId(String uId) {
    if (uId.isEmpty || uId == null) {
      throw new ArgumentError("The user Id cannot be null or empty");
    }
    this._userId = uId;
  }

  get getUserId {
    return this._userId;
  }
}
