import 'package:bloc_to_do_app/1_domain/entities/todo_color.dart';
import 'package:bloc_to_do_app/1_domain/repositories/todo_repository.dart';
import 'package:bloc_to_do_app/1_domain/user_cases/create_todo_collection.dart';
import 'package:bloc_to_do_app/2_application/app/pages/create_todo_collection/bloc/create_todo_collection_cubit.dart';
import 'package:bloc_to_do_app/2_application/core/page_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CreateToDoCollectionPageProvider extends StatelessWidget {
  const CreateToDoCollectionPageProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CreateTodoCollectionCubit>(
      create: (context) => CreateTodoCollectionCubit(
        createToDoCollection: CreateToDoCollection(
          toDoRepository: RepositoryProvider.of<ToDoRepository>(context),
        ),
      ),
      child: const CreateToDoCollectionPage(),
    );
  }
}

class CreateToDoCollectionPage extends StatefulWidget {
  const CreateToDoCollectionPage({super.key});

  static const pageConfig = PageConfig(
    icon: Icons.create,
    name: 'create_todo_collection',
    child: CreateToDoCollectionPageProvider(),
  );

  @override
  State<CreateToDoCollectionPage> createState() => _CreateToDoCollectionPageState();
}

class _CreateToDoCollectionPageState extends State<CreateToDoCollectionPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CreateTodoCollectionCubit>();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Title',
              ),
              onChanged: (value) => cubit.titleChanged(value),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a title';
                }
                return null;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Color',
              ),
              onChanged: (value) => cubit.colorChanged(value),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'please enter a number';
                }
                if (value.isNotEmpty) {
                  final parsedColor = int.tryParse(value);
                  if (parsedColor == null || parsedColor < 0 || parsedColor > ToDoColor.predefinedColors.length) {
                    return 'only numbers between 0 and ${ToDoColor.predefinedColors.length - 1} are optional';
                  }
                }
              },
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                final isFormValid = _formKey.currentState?.validate();

                if (isFormValid == true) {
                  cubit.submit();
                  context.pop();
                }
              },
              child: const Text('Save collection'),
            ),
          ],
        ),
      ),
    );
  }
}