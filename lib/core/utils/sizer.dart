import 'package:flutter/material.dart';

/// Custom responsive sizing utility based on design dimensions.
/// Reference design: iPhone X (375 x 812).
class Sizer {
  static late double _screenWidth;
  static late double _screenHeight;
  static late double _blockSizeHorizontal;
  static late double _blockSizeVertical;

  // Design dimensions (iPhone X as reference)
  static const double designWidth = 375;
  static const double designHeight = 812;

  /// Must be called once in the root widget's build method.
  static void init(BuildContext context) {
    final MediaQueryData mediaQueryData = MediaQuery.of(context);
    _screenWidth = mediaQueryData.size.width;
    _screenHeight = mediaQueryData.size.height;
    _blockSizeHorizontal = _screenWidth / designWidth;
    _blockSizeVertical = _screenHeight / designHeight;
  }

  /// Responsive width.
  static double w(double width) => width * _blockSizeHorizontal;

  /// Responsive height.
  static double h(double height) => height * _blockSizeVertical;

  /// Responsive font size.
  static double sp(double fontSize) => fontSize * _blockSizeHorizontal;

  /// Responsive radius.
  static double r(double radius) => radius * _blockSizeHorizontal;

  /// Screen width.
  static double get screenWidth => _screenWidth;

  /// Screen height.
  static double get screenHeight => _screenHeight;

  /// Vertical spacing widget.
  static Widget verticalSpace(double height) {
    return SizedBox(height: h(height));
  }

  /// Horizontal spacing widget.
  static Widget horizontalSpace(double width) {
    return SizedBox(width: w(width));
  }
}

/// Extension methods for easier responsive sizing usage.
extension SizerExt on num {
  double get w => Sizer.w(toDouble());
  double get h => Sizer.h(toDouble());
  double get sp => Sizer.sp(toDouble());
  double get r => Sizer.r(toDouble());

  Widget get verticalSpace => Sizer.verticalSpace(toDouble());
  Widget get horizontalSpace => Sizer.horizontalSpace(toDouble());
}
