import 'package:flutter/material.dart';
import 'package:hive_ce/hive_ce.dart';
import '../services/hive_service.dart';

class BoxViewScreen extends StatefulWidget {
  final Box box;
  const BoxViewScreen({super.key, required this.box});

  @override
  State<BoxViewScreen> createState() => _BoxViewScreenState();
}

class _BoxViewScreenState extends State<BoxViewScreen> {
  String query = '';

  @override
  Widget build(BuildContext context) {
    final entries = HiveService.read(widget.box).entries.where(
      (e) =>
          e.key.toLowerCase().contains(query.toLowerCase()) ||
          e.value.toString().toLowerCase().contains(query.toLowerCase()),
    );

    return Scaffold(
      appBar: AppBar(title: Text('Box: ${widget.box.name}')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Search key or value',
                border: OutlineInputBorder(),
              ),
              onChanged: (v) => setState(() => query = v),
            ),
          ),
          Expanded(
            child: entries.isEmpty
                ? const Center(child: Text('No matching data'))
                : ListView(
                    children: entries.map((e) {
                      return ListTile(
                        title: Text(e.key),
                        subtitle: Text(
                          e.value.toString(),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            HiveService.delete(widget.box, e.key);
                            setState(() {});
                          },
                        ),
                      );
                    }).toList(),
                  ),
          ),
        ],
      ),
    );
  }
}
