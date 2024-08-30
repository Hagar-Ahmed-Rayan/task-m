import 'package:dartz/dartz.dart';
import 'package:task_manager/common/errors/failure.dart';
import 'package:task_manager/features/home/data/models/todo_model.dart';
import 'package:task_manager/features/home/data/models/todos.dart';

abstract class HomeRepo {
  Future<Either<Failure, TodoModel>> getTasks(int page);
  Future<Either<Failure, Todos>> addTask(Todos task);
}
