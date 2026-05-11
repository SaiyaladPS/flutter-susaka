import 'package:flutter/material.dart';
import 'package:flutter_basess/page/call_list.dart';
import 'package:flutter_basess/page/count.dart';
import 'package:flutter_basess/page/crud_page.dart';
import 'package:flutter_basess/page/chagebg.dart';
import 'package:flutter_basess/page/setting.dart';

class AppRouter {
  static const String home = '/';
  static const String crud = '/crud';
  static const String changeBg = '/change-bg';
  static const String count = '/count';
  static const String call = '/call';
  static const String setting = '/setting';

  static Map<String, WidgetBuilder> get routes => {
    crud: (context) => const CrudPage(),
    changeBg: (context) => const ChangeBgPage(),
    count: (context) => const CountNumber(),
    call: (context) => const CallList(),
    setting: (context) => const SettingPage(),
  };
}
