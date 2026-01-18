import 'dart:convert';
import 'package:hive_ce/hive_ce.dart';

class HiveService {
  static final Map<String, Box> _openedBoxes = {};

  static Future<Box> openBox(String name) async {
    if (_openedBoxes.containsKey(name)) {
      return _openedBoxes[name]!;
    }

    final box = await Hive.openBox(name);
    _openedBoxes[name] = box;
    return box;
  }

  static List<Box> openedBoxes() {
    return _openedBoxes.values.toList();
  }

  static Map<String, dynamic> read(Box box) {
    return {for (var k in box.keys) k.toString(): box.get(k)};
  }

  static void update(Box box, dynamic key, dynamic value) {
    box.put(key, value);
  }

  static void delete(Box box, dynamic key) {
    box.delete(key);
  }

  static String export(Box box) {
    return const JsonEncoder.withIndent('  ').convert(read(box));
  }
}
