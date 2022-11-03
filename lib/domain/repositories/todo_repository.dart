import 'package:dartz/dartz.dart';
import 'package:todo_app/core/failures/todo_failures.dart';

import '../entities/todo.dart';

abstract class TodoRepository{

  Stream <Either<TodoFailure, List<Todo>>> watchAll();  // stream to listen to changes

  Future<Either<TodoFailure, Unit>> create(Todo todo);  //  create, update, delete todo functions

  Future<Either<TodoFailure, Unit>> update(Todo todo);

  Future<Either<TodoFailure, Unit>> delete(Todo todo);

}