import 'package:flutter/foundation.dart';

class AppSettings {
  AppSettings._();

  static final ValueNotifier<bool> darkMode = ValueNotifier<bool>(false);

  static void setDarkMode(bool value) {
    darkMode.value = value;
  }
}
