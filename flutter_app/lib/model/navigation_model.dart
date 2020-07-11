import 'package:flutter/cupertino.dart';

class NavigationModel extends ChangeNotifier {
  int _currentPage = 2;

  set currentPage(int page) {
    this._currentPage = page;
    notifyListeners();
  }

  get currentPage {
    return this._currentPage;
  }
}
