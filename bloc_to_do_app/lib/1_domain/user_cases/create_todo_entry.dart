import 'package:bloc_to_do_app/1_domain/failures/failures.dart';
import 'package:bloc_to_do_app/1_domain/repositories/todo_repository.dart';
import 'package:bloc_to_do_app/3_core/use_case.dart';
import 'package:either_dart/either.dart';

class CreateToDoEntry implements UseCase<bool, ToDoEntryParams> {
  CreateToDoEntry({required this.toDoRepository});

  final ToDoRepository toDoRepository;

  @override
  Future<Either<Failure, bool>> call(params) async {
    try {
      final result = toDoRepository.createToDoEntry(params.entry);

      return result.fold(
        (left) => Left(left),
        (right) => Right(right),
      );
    } on Exception catch (e) {
      return Left(ServerFailure(stackTrace: e.toString()));
    }
  }
}
