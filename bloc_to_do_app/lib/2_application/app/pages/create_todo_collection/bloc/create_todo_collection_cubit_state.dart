part of 'create_todo_collection_cubit.dart';

class CreateTodoCollectionState extends Equatable {
  final String? title;
  final String? color;

  const CreateTodoCollectionState({this.title, this.color});

  CreateTodoCollectionState copyWith({String? title, String? color}) {
    return CreateTodoCollectionState(
      title: title ?? this.title,
      color: color ?? this.color,
    );
  }

  @override
  List<Object?> get props => [title, color];
}
