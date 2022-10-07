import 'package:flutter/material.dart';

class StudentLinkTheme {
  //text size
  double h1 = 22;
  double h2 = 19;
  double h3 = 16;
  double hdes = 15;
  double h4 = 13;
  double h5 = 10;
  double h6 = 8;
//textColor
  Color disText = const Color(0xFF979797);
  Color bg_gray = const Color(0xFFF9F9F9);
  Color bg_gray1 = const Color(0xFFD9D5D5);
  final Color primary1 = Color(0xff112c4f);
  final Color primary2 = Color(0xff3155a1);
  final Color secondarybg = const Color(0xfffff6ed);
  final Color kGreyLightestest = Color(0xFFFAFAFA);
  final Color statusredcolor = Color(0xff861b26);
  final Color statusyellowcolor = Color(0xffca9801);
  final Color statusgreencolor = Color(0xff3f5116);
  ThemeData studentLinkTheme() {
    return ThemeData(
      fontFamily: 'Century Gothic',
      primaryColor: primary1,
      backgroundColor: Color(0xFF112c4f),
      canvasColor: Colors.white,
      hintColor: Colors.white,
      buttonTheme: ButtonThemeData(
        buttonColor: Color(0xff112c4f),
      ),

/*      SliderThemeData.fromPrimaryColors(
		    primaryColor: Colors.amberAccent,
		    primaryColorDark: Colors.red,
		    primaryColorLight: Colors.yellow,
		    valueIndicatorTextStyle: TextStyle(color: activeColor,)),*/
      /*     sliderTheme: SliderThemeData(
          activeTrackColor: primaryPink,
          inactiveTrackColor: inactiveColor,
          trackHeight: 2.0,
          trackShape: RectangularSliderTrackShape(),
          tickMarkShape: RoundSliderTickMarkShape(),
          overlayShape: RoundSliderThumbShape(),
          thumbShape: RoundSliderThumbShape(),
          valueIndicatorShape: RoundSliderOverlayShape(),
          showValueIndicator: ShowValueIndicator.always,
          valueIndicatorTextStyle: TextStyle(color: Colors.black)),*/
    );
  }
}
