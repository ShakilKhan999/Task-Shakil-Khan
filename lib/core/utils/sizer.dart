import 'package:flutter/material.dart';

class Sizer {
  static late double _screenWidth;
  static late double _screenHeight;
  static late double _blockSizeHorizontal;
  static late double _blockSizeVertical;

  static const double designWidth = 375;
  static const double designHeight = 812;

  static void init(BuildContext context) {
    final MediaQueryData mediaQueryData = MediaQuery.of(context);
    _screenWidth = mediaQueryData.size.width;
    _screenHeight = mediaQueryData.size.height;
    _blockSizeHorizontal = _screenWidth / designWidth;
    _blockSizeVertical = _screenHeight / designHeight;
  }

  static double w(double width) => width * _blockSizeHorizontal;

  static double h(double height) => height * _blockSizeVertical;

  static double sp(double fontSize) => fontSize * _blockSizeHorizontal;

  static double r(double radius) => radius * _blockSizeHorizontal;

  static double get screenWidth => _screenWidth;

  static double get screenHeight => _screenHeight;

  static Widget verticalSpace(double height) {
    return SizedBox(height: h(height));
  }

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
