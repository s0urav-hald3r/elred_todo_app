//abhishek360

import 'package:flutter/widgets.dart';

class SizeConfig {
  static MediaQueryData? _mediaQueryData;
  static double? screenWidth;
  static double? screenHeight;

  static double? safeAreaTop;
  static double? safeAreaBottom;

  static void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);

    screenWidth = _mediaQueryData?.size.width;
    screenHeight = _mediaQueryData?.size.height;

    safeAreaTop = _mediaQueryData?.padding.top;
    safeAreaBottom = _mediaQueryData?.padding.bottom;
  }
}
