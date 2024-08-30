import 'package:dartz/dartz.dart';

import 'package:dio/dio.dart';
import 'package:task_manager/common/errors/failure.dart';

import 'package:task_manager/features/home/data/models/todo_model.dart';
import 'package:task_manager/features/home/data/models/todos.dart';
import 'package:task_manager/features/home/data/remote_data_source/remote_data_source.dart';
import 'package:task_manager/features/home/domain/repos/home_repo.dart';

class HomeRepoImpl extends HomeRepo {
  final HomeRemoteDataSource homeRemoteDataSource;

  HomeRepoImpl({required this.homeRemoteDataSource});

  @override
  Future<Either<Failure, TodoModel>> getTasks(int page) async {
    TodoModel? todoModel;
    List<Todos>? todos = [];

    try {
      todoModel = await homeRemoteDataSource.getTasksData(page);

      todos.addAll(todoModel.todos!.toList());
      int x;

      return right(todoModel!);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDiorError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Todos>> addTask(Todos todo) async {
    Todos? task;
    try {
      task = await homeRemoteDataSource.addTask(todo);

      return right(task!);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDiorError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }
}
