// import 'package:flutter/material.dart';

// class ThemeController extends ChangeNotifier {
//   // ✅ Singleton instance
//   static final ThemeController instance = ThemeController._internal();
//   ThemeController._internal();

//   bool _isDark = false;

//   bool get isDark => _isDark;

//   void toggleTheme() {
//     _isDark = !_isDark;
//     notifyListeners(); // tell listeners (like MyApp) to rebuild
//   }
// }
import 'package:flutter/material.dart';

class ThemeController extends ChangeNotifier {
  // Singleton instance
  static final ThemeController instance = ThemeController._internal();
  ThemeController._internal();

  // track dark mode manually
  bool _isDark = false;
  bool get isDark => _isDark;

  // detect system brightness
  void initSystemTheme(Brightness brightness) {
    _isDark = brightness == Brightness.dark;
    notifyListeners();
  }

  // toggle manually
  void toggleTheme() {
    _isDark = !_isDark;
    notifyListeners();
  }
}
