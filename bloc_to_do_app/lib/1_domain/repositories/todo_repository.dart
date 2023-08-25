import 'package:bloc_to_do_app/1_domain/entities/todo_collection.dart';
import 'package:bloc_to_do_app/1_domain/entities/todo_entry.dart';
import 'package:bloc_to_do_app/1_domain/entities/unique_id.dart';
import 'package:bloc_to_do_app/1_domain/failures/failures.dart';
import 'package:either_dart/either.dart';

abstract class ToDoRepository {
  Future<Either<Failure, List<ToDoCollection>>> readToDoCollections();

  Future<Either<Failure, ToDoEntry>> readToDoEntry(CollectionId collectionId, EntryId entryId);

  Future<Either<Failure, List<EntryId>>> readToDoEntryIds(CollectionId collectionId);

  Future<Either<Failure, ToDoEntry>> updateToDoEntry({required CollectionId collectionId, required EntryId entryId});

  Future<Either<Failure, bool>> createToDoCollection(ToDoCollection collection);

  Future<Either<Failure, bool>> createToDoEntry(ToDoEntry entry);
}
