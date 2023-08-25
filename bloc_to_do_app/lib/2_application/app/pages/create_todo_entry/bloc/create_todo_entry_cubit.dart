import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'create_todo_entry_cubit_state.dart';

class CreateTodoEntryCubit extends Cubit<CreateTodoEntryCubitState> {
  CreateTodoEntryCubit() : super(CreateTodoEntryInitial());
}
