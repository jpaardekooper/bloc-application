import 'package:bloc_to_do_app/1_domain/entities/unique_id.dart';
import 'package:bloc_to_do_app/1_domain/user_cases/create_todo_entry.dart';
import 'package:bloc_to_do_app/2_application/app/pages/create_todo_entry/bloc/create_todo_entry_page_cubit.dart';
import 'package:bloc_to_do_app/2_application/core/page_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateToDoEntryPageProvider extends StatelessWidget {
  final CollectionId collectionId;

  const CreateToDoEntryPageProvider({super.key, required this.collectionId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CreateTodoEntryPageCubit>(
      create: (context) => CreateTodoEntryPageCubit(createToDoEntry: collectionId),
      child: const CreateToDoEntryPage(),
    );
  }
}

class CreateToDoEntryPage extends StatelessWidget {
  const CreateToDoEntryPage({super.key});

  static const pageConfig = PageConfig(
    name: 'create_todo_entry',
    icon: Icons.add_task_rounded,
    child: Placeholder(),
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          TextFormField(
            decoration: const InputDecoration(labelText: 'Description'),
            onChanged: (value) {
              // do magic
            },
          ),
        ],
      ),
    );
  }
}
