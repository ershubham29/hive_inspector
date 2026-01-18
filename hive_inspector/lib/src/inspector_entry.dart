import 'package:flutter/material.dart';
import 'package:hive_inspector/src/screens/box_list_screen.dart';

class HiveInspector extends StatelessWidget {
  const HiveInspector({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BoxListScreen(),
    );
  }
}
