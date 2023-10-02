import 'package:flutter/material.dart';

primaryColor(double opacityVal) => Color.fromRGBO(20, 18, 28, opacityVal);
secondaryColor(double opacityVal) => Color.fromRGBO(250, 250, 250, opacityVal);
accentColor(double opacityVal) => Color.fromRGBO(155, 128, 231, opacityVal);
tertiaryColor(double opacityVal) => Color.fromRGBO(34, 33, 46, opacityVal);
deleteColor(double opacityVal) => Color.fromRGBO(243, 36, 36, opacityVal);

fontHeader(colorVal, weightVal) => TextStyle(
      fontSize: 38,
      color: colorVal,
      fontWeight: weightVal,
      letterSpacing: 1.1,
    );

fontDefault(colorVal, weightVal) => TextStyle(
      fontSize: 18,
      color: colorVal,
      fontWeight: weightVal,
      letterSpacing: 1.1,
    );
fontSecondary(colorVal, weightVal) => TextStyle(
      fontSize: 16,
      color: colorVal,
      letterSpacing: 1.1,
    );
fontTertiary(colorVal, weightVal) => TextStyle(
      fontSize: 20,
      color: colorVal,
      fontWeight: weightVal,
      letterSpacing: 1.1,
    );
