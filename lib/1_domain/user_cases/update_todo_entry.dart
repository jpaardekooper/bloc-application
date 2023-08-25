import 'package:bloc_to_do_app/1_domain/entities/todo_entry.dart';
import 'package:bloc_to_do_app/1_domain/failures/failures.dart';
import 'package:bloc_to_do_app/1_domain/repositories/todo_repository.dart';
import 'package:bloc_to_do_app/3_core/use_case.dart';
import 'package:either_dart/either.dart';
import 'package:either_dart/src/either.dart';

class UpdateToDoEntry implements UseCase<ToDoEntry, ToDoEntryIdsParam> {
  final ToDoRepository toDoRepository;

  UpdateToDoEntry({required this.toDoRepository});

  @override
  Future<Either<Failure, ToDoEntry>> call(ToDoEntryIdsParam params) async {
    try {
      final loadedEntry = await toDoRepository.updateToDoEntry(
        collectionId: params.collectionId,
        entryId: params.entryId,
      );

      return loadedEntry.fold(
        (left) => Left(left),
        (right) => Right(right),
      );
    } on Exception catch (e) {
      return Left(ServerFailure(stackTrace: e.toString()));
    }
  }
}
