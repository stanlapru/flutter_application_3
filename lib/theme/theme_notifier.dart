import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeNotifier extends ChangeNotifier {
  ThemeMode _mode;
  late ThemeData lightTheme;
  late ThemeData darkTheme;

  ThemeMode get themeMode => _mode;

  ThemeNotifier({
    required this.lightTheme,
    required this.darkTheme,
    required String initialTheme,
  }) : _mode = initialTheme.contains('dark') ? ThemeMode.dark : ThemeMode.light;

  void setTheme(String theme) async {
    final prefs = await SharedPreferences.getInstance();

    _mode = theme == 'dark' ? ThemeMode.dark : ThemeMode.light;

    await prefs.setString('theme', theme);
    notifyListeners();
  }
}
