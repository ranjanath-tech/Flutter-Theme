import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:theme_proj/data/hive_box.dart';
import '../models/task.dart';
import 'dart:async';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final Box<Task> tasksBox = Hive.box<Task>(HiveBoxes.tasks);

    return Scaffold(
      appBar: AppBar(title: const Text('Hive Todo')),
      body: ValueListenableBuilder<Box<Task>>(
        valueListenable: tasksBox.listenable(),
        builder: (context, box, _) {
          if (box.isEmpty) {
            return const Center(child: Text('No tasks yet. Tap + to add.'));
          }
          final tasks = box.values.toList().cast<Task>();
          tasks.sort((a, b) => a.createdAt.compareTo(b.createdAt));

          return ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, i) {
              final task = tasks[i];
              return Dismissible(
                key: ValueKey(task.key),
                background: Container(color: Colors.redAccent),
                onDismissed: (_) => task.delete(),
                child: CheckboxListTile(
                  title: Text(
                    task.title,
                    style: TextStyle(
                      decoration: task.done ? TextDecoration.lineThrough : null,
                    ),
                  ),
                  subtitle: task.note?.isNotEmpty == true ? Text(task.note!) : null,
                  value: task.done,
                  onChanged: (v) async {
                    task.done = v ?? false;
                    await task.save();
                  },
                  secondary: IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () => _showAddOrEditTaskDialog(context, existing: task),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddOrEditTaskDialog(context),
        label: const Text('Add'),
        icon: const Icon(Icons.add),
      ),
    );
  }
}

Future<void> _showAddOrEditTaskDialog(BuildContext context, {Task? existing}) async {
  final titleCtrl = TextEditingController(text: existing?.title ?? '');
  final noteCtrl = TextEditingController(text: existing?.note ?? '');
  final formKey = GlobalKey<FormState>();
  final Box<Task> box = Hive.box<Task>(HiveBoxes.tasks);

  await showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: Text(existing == null ? 'New task' : 'Edit task'),
      content: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: titleCtrl,
              decoration: const InputDecoration(labelText: 'Title'),
              validator: (v) => (v == null || v.trim().isEmpty) ? 'Enter a title' : null,
            ),
            TextFormField(
              controller: noteCtrl,
              decoration: const InputDecoration(labelText: 'Note (optional)'),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
        ElevatedButton(
          onPressed: () async {
            if (!formKey.currentState!.validate()) return;
            final title = titleCtrl.text.trim();
            final note = noteCtrl.text.trim().isEmpty ? null : noteCtrl.text.trim();
            if (existing == null) {
              await box.add(Task(title: title, note: note));
            } else {
              existing
                ..title = title
                ..note = note;
              await existing.save();
            }
            if (context.mounted) Navigator.pop(context);
          },
          child: Text(existing == null ? 'Add' : 'Save'),
        ),
      ],
    ),
  );
}
