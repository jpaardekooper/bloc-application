import 'package:bloc_to_do_app/1_domain/entities/todo_entry.dart';
import 'package:bloc_to_do_app/1_domain/entities/unique_id.dart';
import 'package:bloc_to_do_app/1_domain/user_cases/load_todo_entry_ids_for_collection.dart';
import 'package:bloc_to_do_app/1_domain/user_cases/update_todo_entry.dart';
import 'package:bloc_to_do_app/3_core/use_case.dart';
import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'todo_entry_item_cubit_state.dart';

class TodoEntryItemCubit extends Cubit<TodoEntryItemState> {
  final EntryId entryId;

  final CollectionId collectionId;

  final LoadToDoEntry loadToDoEntry;

  final UpdateToDoEntry updateToDoEntry;

  //final updateToDoEntry

  TodoEntryItemCubit({
    required this.entryId,
    required this.collectionId,
    required this.loadToDoEntry,
    required this.updateToDoEntry,
  }) : super(TodoEntryItemLoadingState());

  Future<void> fetch() async {
    emit(TodoEntryItemLoadingState());
    try {
      final entry = await loadToDoEntry.call(
        ToDoEntryIdsParam(collectionId: collectionId, entryId: entryId),
      );

      return entry.fold(
        (left) => Left(
          emit(TodoEntryItemErrorState()),
        ),
        (right) => Right(
          emit(TodoEntryItemLoadedState(toDoEntry: entry.right)),
        ),
      );
    } on Exception {
      emit(TodoEntryItemErrorState());
    }
  }

  Future<void> update() async {
    try {
      final updatedEntry = await updateToDoEntry.call(
        ToDoEntryIdsParam(collectionId: collectionId, entryId: entryId),
      );

      return updatedEntry.fold(
        (left) => Left(
          emit(TodoEntryItemErrorState()),
        ),
        (right) => Right(
          emit(TodoEntryItemLoadedState(toDoEntry: right)),
        ),
      );
    } on Exception {
      emit(TodoEntryItemErrorState());
    }
  }
}
