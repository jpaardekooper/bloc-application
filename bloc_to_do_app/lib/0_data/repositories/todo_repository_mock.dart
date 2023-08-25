import 'package:bloc_to_do_app/1_domain/entities/todo_collection.dart';
import 'package:bloc_to_do_app/1_domain/entities/todo_color.dart';
import 'package:bloc_to_do_app/1_domain/entities/todo_entry.dart';
import 'package:bloc_to_do_app/1_domain/entities/unique_id.dart';
import 'package:bloc_to_do_app/1_domain/failures/failures.dart';
import 'package:bloc_to_do_app/1_domain/repositories/todo_repository.dart';
import 'package:either_dart/either.dart';

class ToDoRepositoryMock implements ToDoRepository {
  final List<ToDoEntry> toDoEntries = List.generate(
    100,
    (index) => ToDoEntry(
      id: EntryId.fromUniqueString(index.toString()),
      description: 'description $index',
      isDone: false,
    ),
  );

  final toDoCollections = List<ToDoCollection>.generate(
    10,
    (index) => ToDoCollection(
      id: CollectionId.fromUniqueString(index.toString()),
      title: 'title $index',
      color: ToDoColor(
        colorIndex: index % ToDoColor.predefinedColors.length,
      ),
    ),
  );

  @override
  Future<Either<Failure, List<ToDoCollection>>> readToDoCollections() async {
    if (toDoCollections.isNotEmpty) {
      return Right(toDoCollections);
    }
    try {
      return Future.delayed(
        const Duration(milliseconds: 500),
        () => Right(toDoCollections),
      );
    } on Exception catch (e) {
      return Future.value(Left(ServerFailure(stackTrace: e.toString())));
    }
  }

  @override
  Future<Either<Failure, ToDoEntry>> readToDoEntry(CollectionId collectionId, EntryId entryId) {
    try {
      final selectedEntryItem = toDoEntries.firstWhere(
        (element) => element.id == entryId,
      );

      return Future.delayed(
        const Duration(milliseconds: 250),
        () => Right(selectedEntryItem),
      );
    } on Exception catch (e) {
      return Future.value(Left(ServerFailure(stackTrace: e.toString())));
    }
  }

  @override
  Future<Either<Failure, List<EntryId>>> readToDoEntryIds(CollectionId collectionId) {
    try {
      final startIndex = int.parse(collectionId.value) * 10;
      final endIndex = startIndex + 10;
      final entryIds = toDoEntries.sublist(startIndex, endIndex).map((entry) => entry.id).toList();

      return Future.delayed(
        const Duration(milliseconds: 300),
        () => Right(entryIds),
      );
    } on Exception catch (e) {
      return Future.value(Left(ServerFailure(stackTrace: e.toString())));
    }
  }

  @override
  Future<Either<Failure, ToDoEntry>> updateToDoEntry({required CollectionId collectionId, required EntryId entryId}) {
    final index = toDoEntries.indexWhere((element) => element.id == entryId);
    final entryToUpdate = toDoEntries[index];
    final updatedEntry = entryToUpdate.copyWith(isDone: !entryToUpdate.isDone);

    toDoEntries[index] = updatedEntry;

    return Future.delayed(
      const Duration(milliseconds: 100),
      () => Right(updatedEntry),
    );
  }

  @override
  Future<Either<Failure, bool>> createToDoCollection({required ToDoCollection collection}) {
    toDoCollections.add(collection);

    return Future.delayed(
      const Duration(milliseconds: 250),
      () => const Right(true),
    );
  }

  @override
  Future<Either<Failure, bool>> createToDoEntry(ToDoEntry entry) {
    toDoEntries.add(entry);
    return Future.delayed(const Duration(milliseconds: 250), () => const Right(true));
  }
}
