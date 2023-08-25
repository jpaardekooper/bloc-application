import 'package:bloc_to_do_app/1_domain/entities/unique_id.dart';
import 'package:bloc_to_do_app/2_application/app/components/todo_entry_item/todo_entry_item.dart';
import 'package:flutter/material.dart';

class ToDoDetailLoaded extends StatelessWidget {
  const ToDoDetailLoaded({
    super.key,
    required this.collectionId,
    required this.entryIds,
  });

  final List<EntryId> entryIds;
  final CollectionId collectionId;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: entryIds.length,
          itemBuilder: (context, index) {
            return ToDoEntryItemProvider(
              collectionId: collectionId,
              entryId: entryIds[index],
            );
          },
        ),
      ),
    );
  }
}
