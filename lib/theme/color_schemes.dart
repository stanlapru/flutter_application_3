import 'package:flutter/material.dart';
import 'package:flutter_application_2/theme/text_themes.dart';

ThemeData createLightColorData() {
  return ThemeData(
    colorScheme: createLightColorScheme(), 
    textTheme: textTheme
  );
}

ThemeData createDarkColorData() {
  return ThemeData(
    colorScheme: createDarkColorScheme(), 
    textTheme: textTheme
  );
}

ColorScheme createLightColorScheme() {
  return ColorScheme(
    brightness: Brightness.light,
    primary: Colors.amber,
    onPrimary: Colors.black,
    secondary: Colors.lightGreen,
    onSecondary: const Color.fromARGB(255, 207, 214, 200),
    error: Colors.red,
    onError: const Color.fromARGB(255, 238, 205, 203),
    surface: Colors.white,
    onSurface: Colors.black,
  );
}

ColorScheme createDarkColorScheme() {
  return ColorScheme(
    brightness: Brightness.dark,
    primary: Colors.amber,
    onPrimary: Colors.white,
    secondary: const Color.fromARGB(255, 69, 97, 37),
    onSecondary: const Color.fromARGB(255, 192, 214, 169),
    error: const Color.fromARGB(255, 162, 44, 36),
    onError: const Color.fromARGB(255, 234, 161, 157),
    surface: Colors.black,
    onSurface: Colors.white,
  );
}
