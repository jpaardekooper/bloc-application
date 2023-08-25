import 'package:bloc_to_do_app/1_domain/entities/todo_entry.dart';
import 'package:bloc_to_do_app/1_domain/entities/unique_id.dart';
import 'package:bloc_to_do_app/1_domain/user_cases/create_todo_entry.dart';
import 'package:bloc_to_do_app/2_application/core/form_value.dart';
import 'package:bloc_to_do_app/3_core/use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'create_todo_entry_page_cubit_state.dart';

class CreateTodoEntryPageCubit extends Cubit<CreateTodoEntryPageCubitState> {
  final CollectionId collectionId;
  final CreateToDoEntry addToDoEntry;

  CreateTodoEntryPageCubit({required this.collectionId, required this.addToDoEntry})
      : super(const CreateTodoEntryPageCubitState());

  void descriptionChanged({String? description}) {
    ValidationStatus currentStatus = ValidationStatus.pending;

    if (description == null || description.isEmpty || description.length < 2) {
      currentStatus = ValidationStatus.error;
    } else {
      currentStatus = ValidationStatus.succes;
    }
    emit(state.copyWith(description: FormValue(value: description, validationStatus: currentStatus)));
  }

  void submit() async {
    await addToDoEntry.call(
      ToDoEntryParams(
        entry: ToDoEntry.empty().copyWith(
          description: state.description?.value,
        ),
      ),
    );
  }
}
