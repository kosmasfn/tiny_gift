import 'package:flutter/material.dart';

// Define the custom theme extension
class CustomColorsTheme extends ThemeExtension<CustomColorsTheme> {
  final Color primaryColor;
  final Color secondaryColor;

  // Constructor for the custom theme extension
  CustomColorsTheme({
    required this.primaryColor,
    required this.secondaryColor,
  });

  get activeNavigationBarColor => Colors.green;

  get notActiveNavigationBarColor => Colors.greenAccent;

  get bottomNavigationBarBackgroundColor => Colors.black;

  @override
  CustomColorsTheme copyWith({
    Color? primaryColor,
    Color? secondaryColor,
  }) {
    return CustomColorsTheme(
      primaryColor: primaryColor ?? this.primaryColor,
      secondaryColor: secondaryColor ?? this.secondaryColor,
    );
  }

  @override
  CustomColorsTheme lerp(CustomColorsTheme? other, double t) {
    if (other == null) return this;
    return CustomColorsTheme(
      primaryColor: Color.lerp(primaryColor, other.primaryColor, t)!,
      secondaryColor: Color.lerp(secondaryColor, other.secondaryColor, t)!,
    );
  }
}
