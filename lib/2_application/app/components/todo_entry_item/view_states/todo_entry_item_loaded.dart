import 'package:bloc_to_do_app/1_domain/entities/todo_entry.dart';
import 'package:flutter/material.dart';

class ToDoEntryItemLoaded extends StatelessWidget {
  final ToDoEntry entryItem;
  final Function(bool?) onChanged;

  const ToDoEntryItemLoaded({
    super.key,
    required this.entryItem,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      value: entryItem.isDone,
      title: Text(entryItem.description),
      onChanged: onChanged,
    );
  }
}
