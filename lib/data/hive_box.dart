import 'package:hive_flutter/hive_flutter.dart';

class HiveBoxes {
  static const tasks = 'tasks';
  static const settings = 'settings';

  static Future<void> init() async {
    await Hive.initFlutter();
  }
}
