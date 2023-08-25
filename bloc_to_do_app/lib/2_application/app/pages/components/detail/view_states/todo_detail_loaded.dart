import 'package:bloc_to_do_app/1_domain/entities/unique_id.dart';
import 'package:bloc_to_do_app/2_application/app/components/todo_entry_item/todo_entry_item.dart';
import 'package:bloc_to_do_app/2_application/app/pages/components/detail/bloc/todo_detail_cubit.dart';
import 'package:bloc_to_do_app/2_application/app/pages/create_todo_collection/create_todo_collection_page.dart';
import 'package:bloc_to_do_app/2_application/app/pages/create_todo_entry/create_todo_entry_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ToDoDetailLoaded extends StatelessWidget {
  final List<EntryId> entryIds;
  final CollectionId collectionId;

  const ToDoDetailLoaded({
    super.key,
    required this.collectionId,
    required this.entryIds,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Padding(
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
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FloatingActionButton(
                key: const Key('create_todo_entry'),
                heroTag: 'create_todo_entry',
                onPressed: () {
                  context.pushNamed(
                    CreateToDoEntryPage.pageConfig.name,
                    extra: CreateToDoEntryPageExtra(
                      collectionId: collectionId,
                      toDoEntryItemAddedCallBack: () => context.read<ToDoDetailCubit>().fetch(),
                    ),
                  );
                },
                child: const Icon(Icons.add_rounded),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
