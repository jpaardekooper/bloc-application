import 'package:bloc_to_do_app/1_domain/entities/unique_id.dart';
import 'package:bloc_to_do_app/1_domain/repositories/todo_repository.dart';
import 'package:bloc_to_do_app/1_domain/user_cases/load_todo_entry_ids_for_collection.dart';
import 'package:bloc_to_do_app/1_domain/user_cases/update_todo_entry.dart';
import 'package:bloc_to_do_app/2_application/app/components/todo_entry_item/bloc/todo_entry_item_cubit.dart';
import 'package:bloc_to_do_app/2_application/app/components/todo_entry_item/view_states/todo_entry_item_error.dart';
import 'package:bloc_to_do_app/2_application/app/components/todo_entry_item/view_states/todo_entry_item_loaded.dart';
import 'package:bloc_to_do_app/2_application/app/components/todo_entry_item/view_states/todo_entry_item_loading.dart';
import 'package:bloc_to_do_app/2_application/core/page_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ToDoEntryItemProvider extends StatelessWidget {
  final CollectionId collectionId;
  final EntryId entryId;

  const ToDoEntryItemProvider({
    super.key,
    required this.collectionId,
    required this.entryId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TodoEntryItemCubit>(
      create: (context) => TodoEntryItemCubit(
        collectionId: collectionId,
        entryId: entryId,
        loadToDoEntry: LoadToDoEntry(
          toDoRepository: RepositoryProvider.of<ToDoRepository>(context),
        ),
        updateToDoEntry: UpdateToDoEntry(
          toDoRepository: RepositoryProvider.of<ToDoRepository>(context),
        ),
      )..fetch(),
      child: const ToDoEntryItem(),
    );
  }
}

class ToDoEntryItem extends StatelessWidget {
  const ToDoEntryItem({super.key});

  static const PageConfig pageConfig = PageConfig(
    icon: Icons.energy_savings_leaf,
    name: 'detail',
  );

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoEntryItemCubit, TodoEntryItemState>(
      builder: (context, state) {
        if (state is TodoEntryItemLoadingState) {
          return const ToDoEntryItemLoading();
        } else if (state is TodoEntryItemLoadedState) {
          return ToDoEntryItemLoaded(
            entryItem: state.toDoEntry,
            onChanged: (value) => context.read<TodoEntryItemCubit>().update(),
          );
        } else {
          return const ToDoEntryItemError();
        }
      },
    );
  }
}
