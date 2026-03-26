import 'package:flutter/material.dart';
import 'package:flutter_basess/page/count.dart';
import 'package:flutter_basess/page/crud_page.dart';
import 'package:flutter_basess/page/chagebg.dart';

class AppRouter {
  static const String home = '/';
  static const String crud = '/crud';
  static const String changeBg = '/change-bg';
  static const String count = '/count';

  static Map<String, WidgetBuilder> get routes => {
    crud: (context) => const CrudPage(),
    changeBg: (context) => const ChangeBgPage(),
    count: (context) => const CountNumber(),
  };
}
