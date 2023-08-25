import 'package:bloc_to_do_app/1_domain/entities/unique_id.dart';
import 'package:bloc_to_do_app/1_domain/user_cases/create_todo_entry.dart';
import 'package:bloc_to_do_app/2_application/core/form_value.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'create_todo_entry_page_cubit_state.dart';

class CreateTodoEntryPageCubit extends Cubit<CreateTodoEntryPageCubitState> {
  final CollectionId collectionId;
  final CreateToDoEntry createToDoEntry;

  CreateTodoEntryPageCubit({required this.collectionId, required this.createToDoEntry})
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

  void submit() {}
}
