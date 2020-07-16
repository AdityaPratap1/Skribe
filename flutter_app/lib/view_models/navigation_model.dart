import 'package:flutter/cupertino.dart';

/// This class is the view-model class of the MVVM software architecture.
/// This class is also the part of the provider state management design pattern.
/// The state of the pageview in the homepage is kept track here.
///
/// @author [Aditya Pratap]
/// @version 1.0
class NavigationModel extends ChangeNotifier {
  int _currentPage = 2;

  /// This setter method sets the index of the current page in the pageview.
  ///
  /// @param [page] The index of the current page.
  ///
  /// @precondition The [page] must be greater than or equal to 0.
  /// @postcondition The state of the index of the page is assigned.
  set currentPage(int page) {
    if (page < 0) {
      throw new ArgumentError("The page index cannot be less than 0");
    }
    this._currentPage = page;
    notifyListeners();
  }

  /// This getter method gets the index of the current page.
  /// 
  /// @precondition none.
  /// @return The index of the current page.
  get currentPage {
    return this._currentPage;
  }
}
