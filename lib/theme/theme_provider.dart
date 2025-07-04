import 'package:flutter/material.dart';
import 'theme_prefs.dart'; // Nome atualizado do arquivo

class ThemeProvider extends ChangeNotifier {
  bool _isDarkMode = false;
  bool get isDarkMode => _isDarkMode;

  final ThemePrefs _themePrefs = ThemePrefs();

  ThemeProvider() {
    _loadTheme();
  }

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    _themePrefs.saveTheme(_isDarkMode);
    notifyListeners();
  }

  Future<void> _loadTheme() async {
    _isDarkMode = await _themePrefs.loadTheme();
    notifyListeners();
  }
}
