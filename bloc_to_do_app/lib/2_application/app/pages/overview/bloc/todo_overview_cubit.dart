import 'package:bloc_to_do_app/1_domain/entities/todo_collection.dart';
import 'package:bloc_to_do_app/1_domain/user_cases/load_todo_collections.dart';
import 'package:bloc_to_do_app/3_core/use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'todo_overview_cubit_state.dart';

class ToDoOverviewCubit extends Cubit<ToDoOverviewCubitState> {
  final LoadToDoCollections loadToDoCollections;

  ToDoOverviewCubit({
    required this.loadToDoCollections,
    ToDoOverviewCubitState? initialState,
  }) : super(initialState ?? ToDoOverviewCubitLoadingState()) {}

  Future<void> readToDoCollections() async {
    emit(ToDoOverviewCubitLoadingState());
    try {
      final collectionsFuture = loadToDoCollections.call(NoParams());

      final collections = await collectionsFuture;

      if (collections.isLeft) {
        emit(ToDoOverviewCubitErrorState());
      } else {
        emit(ToDoOverviewCubitLoadedState(collections: collections.right));
      }
    } on Exception {
      emit(ToDoOverviewCubitErrorState());
    }
  }
}
