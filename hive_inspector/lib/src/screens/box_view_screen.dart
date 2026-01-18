import 'dart:convert';
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

  void _editValue(BuildContext context, String key, dynamic value) {
    final controller = TextEditingController(
      text: value is String ? value : jsonEncode(value),
    );

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Edit "$key"'),
        content: TextField(
          controller: controller,
          maxLines: 6,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Enter new value (JSON supported)',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              dynamic newValue;
              final text = controller.text.trim();

              try {
                newValue = jsonDecode(text);
              } catch (_) {
                newValue = text;
              }

              HiveService.update(widget.box, key, newValue);
              Navigator.pop(context);
              setState(() {});
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _exportJson(BuildContext context) {
    final json = HiveService.export(widget.box);

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Export Box as JSON'),
        content: SizedBox(
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: SelectableText(json, style: const TextStyle(fontSize: 12)),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final entries = HiveService.read(widget.box).entries.where(
      (e) =>
          e.key.toLowerCase().contains(query.toLowerCase()) ||
          e.value.toString().toLowerCase().contains(query.toLowerCase()),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Box: ${widget.box.name}'),
        actions: [
          IconButton(
            icon: const Icon(Icons.download),
            tooltip: 'Export JSON',
            onPressed: () => _exportJson(context),
          ),
        ],
      ),

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
                        trailing: Wrap(
                          spacing: 8,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit, color: Colors.blue),
                              onPressed: () =>
                                  _editValue(context, e.key, e.value),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                HiveService.delete(widget.box, e.key);
                                setState(() {});
                              },
                            ),
                          ],
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
