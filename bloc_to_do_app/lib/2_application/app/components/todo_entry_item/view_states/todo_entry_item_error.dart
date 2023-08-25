import 'package:flutter/material.dart';

class ToDoEntryItemError extends StatelessWidget {
  const ToDoEntryItemError({super.key});

  @override
  Widget build(BuildContext context) {
    return const ListTile(
      title: Text('Could not load item'),
    );
  }
}