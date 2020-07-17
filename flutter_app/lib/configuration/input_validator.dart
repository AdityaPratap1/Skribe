/// This class contains validations for any input fields used in this app.
/// The validations are usually validations for a specific format or comparisions.
///
/// @author [Aditya Pratap]
/// @version 1.0
class InputValidator {
  /// This method validates the email address from any email address field.
  /// The validation checks for a standard email address form.
  ///
  /// @param [value] The email address to be validated.
  ///
  /// @precondition The [value] cannot be null or empty.
  /// @return The error message if validation fails.
  static String email(String value) {
    if (value.isEmpty || value == null) {
      return 'Email is required to sign up';
    }

    value = value.trim();

    if (!value.contains('@')) {
      return 'Please enter a valid email address';
    }

    return null;
  }

  /// This method validates the email address from any email address field.
  /// The validation checks for a standard email address form.
  ///
  /// @param [value] The email address to be validated.
  ///
  /// @precondition The [value] cannot be null or empty.
  /// @return The error message if validation fails.
  static String resetEmail(String value) {
    value = value.trim();

    if (value.isEmpty) {
      return 'Email is required to reset';
    }

    if (!value.contains('@')) {
      return 'Please enter a valid email address';
    }

    return null;
  }

  /// This method validates the first name from any first name field.
  /// The validation chaecks for a non-empty and a non-null input..
  ///
  /// @param [value] The first name to be validated.
  ///
  /// @precondition The [value] cannot be null or empty.
  /// @return The error message if validation fails.
  static String fname(String value) {
    return value.isEmpty ? 'First name can\'t be empty' : null;
  }

  /// This method validates the last name from any last name field.
  /// The validation chaecks for a non-empty and a non-null input..
  ///
  /// @param [value] The last name to be validated.
  ///
  /// @precondition The [value] cannot be null or empty.
  /// @return The error message if validation fails.
  static String lname(String value) {
    return value.isEmpty ? 'Last name can\'t be empty' : null;
  }

  /// This method validates the password from any password field.
  /// The validation chaecks for a non-empty and a non-null input..
  ///
  /// @param [value] The password to be validated.
  ///
  /// @precondition The [value] cannot be null or empty.
  /// @return The error message if validation fails.
  static String password(String value) {
    if (value.isEmpty || value.length < 8) {
      return 'Password must be at least 8 characters';
    }
    return null;
  }

  static String todoAspects(String value) {
    return value.isEmpty ? "This value cannot be empty" : null;
  }
}
