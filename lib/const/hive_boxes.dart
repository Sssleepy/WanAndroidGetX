import 'package:hive_flutter/hive_flutter.dart';

const String boxPrefix = 'wanAndroid';

class HiveBoxes {
  const HiveBoxes._();

  static late Box<bool> loginBox;

  static late Box<bool> darkBox;

  static Future<void> openBoxes() async {
    // Hive..registerAdapter(adapter);

    await Future.wait(<Future<void>>[
      () async {
        loginBox = await Hive.openBox("${boxPrefix}_login");
      }(),
      () async {
        darkBox = await Hive.openBox("${boxPrefix}_dark");
      }(),
    ]);
  }
}