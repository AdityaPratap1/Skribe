import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';

/// This class encapsulates the size configurations of the app.
/// The size configurations include screen height and width and safe areas.
///
/// Anytime the screen's height and width are needed, can be accessed from this class
/// without using Mediaquery at that location.
/// 
/// @author [Aditya Pratap]
/// @version 1.0
///
class SizeConfig {
  static MediaQueryData _mediaQueryData;
  static double screenWidth;
  static double screenHeight;
  static double blockSizeHorizontal;
  static double blockSizeVertical;
  static double _safeAreaVertical;
  static double _safeAreaHorizontal;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    blockSizeHorizontal = _mediaQueryData.size.width;
    blockSizeVertical = _mediaQueryData.size.height;

    _safeAreaVertical =
        _mediaQueryData.padding.top + _mediaQueryData.padding.bottom;

    _safeAreaHorizontal =
        _mediaQueryData.padding.left + _mediaQueryData.padding.right;

    screenWidth = (blockSizeHorizontal - _safeAreaHorizontal);
    screenHeight = (blockSizeVertical - _safeAreaVertical);
  }
}
