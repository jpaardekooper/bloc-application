part of 'create_todo_entry_page_cubit.dart';

class CreateTodoEntryPageCubitState extends Equatable {
  final FormValue<String?>? description;

  const CreateTodoEntryPageCubitState({this.description});

  CreateTodoEntryPageCubitState copyWith({FormValue<String?>? description}) {
    return CreateTodoEntryPageCubitState(
      description: description ?? this.description,
    );
  }

  @override
  List<Object?> get props => [description];
}
