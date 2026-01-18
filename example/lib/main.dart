import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';
import 'package:hive_inspector/hive_inspector.dart';
import 'package:hive_inspector/src/services/hive_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  final demoBox = await HiveService.openBox('demoBox');
  await HiveService.openBox('userBox');

  demoBox.put('name', 'shubham');
  demoBox.put('count', 5);
  demoBox.put('data', {'a': 1, 'b': true});

  runApp(const HiveInspector());
}
