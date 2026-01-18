import 'package:flutter/material.dart';
import 'package:hive_ce/hive_ce.dart';
import '../services/hive_service.dart';
import 'box_view_screen.dart';

class BoxListScreen extends StatelessWidget {
  const BoxListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final boxes = HiveService.openedBoxes();

    return Scaffold(
      appBar: AppBar(title: const Text('Hive Boxes')),
      body: boxes.isEmpty
          ? const Center(
              child: Text(
                'No Hive boxes opened.\nOpen boxes using HiveService.openBox()',
                textAlign: TextAlign.center,
              ),
            )
          : ListView.builder(
              itemCount: boxes.length,
              itemBuilder: (_, i) {
                final Box box = boxes[i];
                return ListTile(
                  title: Text(box.name),
                  subtitle: Text('Items: ${box.length}'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => BoxViewScreen(box: box),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
