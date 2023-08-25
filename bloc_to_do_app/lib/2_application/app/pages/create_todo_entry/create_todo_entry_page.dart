import 'package:bloc_to_do_app/1_domain/entities/unique_id.dart';
import 'package:bloc_to_do_app/1_domain/repositories/todo_repository.dart';
import 'package:bloc_to_do_app/1_domain/user_cases/create_todo_entry.dart';
import 'package:bloc_to_do_app/2_application/app/pages/create_todo_entry/bloc/create_todo_entry_page_cubit.dart';
import 'package:bloc_to_do_app/2_application/core/form_value.dart';
import 'package:bloc_to_do_app/2_application/core/page_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

typedef ToDoEntryItemAddedCallBack = Function();

class CreateToDoEntryPageProvider extends StatelessWidget {
  final CollectionId collectionId;
  final ToDoEntryItemAddedCallBack toDoEntryItemAddedCallBack;

  const CreateToDoEntryPageProvider({
    super.key,
    required this.collectionId,
    required this.toDoEntryItemAddedCallBack,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CreateTodoEntryPageCubit>(
      create: (context) => CreateTodoEntryPageCubit(
        collectionId: collectionId,
        addToDoEntry: CreateToDoEntry(
          toDoRepository: RepositoryProvider.of<ToDoRepository>(context),
        ),
      ),
      child: CreateToDoEntryPage(
        toDoEntryItemAddedCallBack: toDoEntryItemAddedCallBack,
      ),
    );
  }
}

class CreateToDoEntryPage extends StatefulWidget {
  final ToDoEntryItemAddedCallBack toDoEntryItemAddedCallBack;

  const CreateToDoEntryPage({super.key, required this.toDoEntryItemAddedCallBack});

  static const pageConfig = PageConfig(
    name: 'create_todo_entry',
    icon: Icons.add_task_rounded,
    child: Placeholder(),
  );

  @override
  State<CreateToDoEntryPage> createState() => _CreateToDoEntryPageState();
}

class _CreateToDoEntryPageState extends State<CreateToDoEntryPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'Description'),
              validator: (value) {
                final currentValidationState =
                    context.read<CreateTodoEntryPageCubit>().state.description?.validationStatus ??
                        ValidationStatus.pending;

                switch (currentValidationState) {
                  case ValidationStatus.error:
                    return 'This needs at least two characters to be valid';
                  case ValidationStatus.pending:
                  case ValidationStatus.succes:
                  default:
                    return null;
                }
              },
              onChanged: (value) {
                context.read<CreateTodoEntryPageCubit>().descriptionChanged(description: value);
              },
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                final isFormValid = _formKey.currentState?.validate();

                if (isFormValid == true) {
                  context.read<CreateTodoEntryPageCubit>().submit();
                  widget.toDoEntryItemAddedCallBack();
                  context.pop();
                }
              },
              child: const Text('Submit'),
            )
          ],
        ),
      ),
    );
  }
}
