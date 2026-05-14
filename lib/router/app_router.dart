import 'package:flutter/material.dart';
import 'package:flutter_basess/page/call_list.dart';
import 'package:flutter_basess/page/count.dart';
import 'package:flutter_basess/page/crud_page.dart';
import 'package:flutter_basess/page/chagebg.dart';
import 'package:flutter_basess/page/setting.dart';
import 'package:flutter_basess/page/exam_subject_list.dart';
import 'package:flutter_basess/page/exam_detail.dart';
import 'package:flutter_basess/page/admin_dashboard.dart';

class AppRouter {
  static const String home = '/';
  static const String crud = '/crud';
  static const String changeBg = '/change-bg';
  static const String count = '/count';
  static const String call = '/call';
  static const String setting = '/setting';
  static const String examList = '/exam-list';
  static const String examDetail = '/exam-detail';
  static const String adminDashboard = '/admin-dashboard';

  static Map<String, WidgetBuilder> get routes => {
    crud: (context) => const CrudPage(),
    changeBg: (context) => const ChangeBgPage(),
    count: (context) => const CountNumber(),
    call: (context) => const CallList(),
    setting: (context) => const SettingPage(),
    examList: (context) => const ExamSubjectListPage(),
    examDetail: (context) => const ExamDetailPage(),
    adminDashboard: (context) => const AdminDashboardPage(),
  };
}
