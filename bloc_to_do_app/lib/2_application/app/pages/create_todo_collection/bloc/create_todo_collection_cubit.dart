import 'package:bloc_to_do_app/1_domain/entities/todo_collection.dart';
import 'package:bloc_to_do_app/1_domain/entities/todo_color.dart';
import 'package:bloc_to_do_app/1_domain/user_cases/create_todo_collection.dart';
import 'package:bloc_to_do_app/3_core/use_case.dart';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'create_todo_collection_cubit_state.dart';

class CreateTodoCollectionCubit extends Cubit<CreateTodoCollectionState> {
  final CreateToDoCollection createToDoCollection;
  CreateTodoCollectionCubit({required this.createToDoCollection}) : super(const CreateTodoCollectionState());

  void titleChanged(String title) {
    emit(state.copyWith(title: title));
  }

  void colorChanged(String color) {
    emit(state.copyWith(color: color));
  }

  Future<void> submit() async {
    final parsedColorIndex = int.tryParse(state.color ?? '') ?? 0;
    await createToDoCollection.call(
      ToDoCollectionParams(
        collection: ToDoCollection.empty().copyWith(
          title: state.title,
          color: ToDoColor(colorIndex: parsedColorIndex),
        ),
      ),
    );
  }
}
