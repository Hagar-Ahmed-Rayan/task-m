import 'package:dartz/dartz.dart';
import 'package:task_manager/common/errors/failure.dart';
import 'package:task_manager/features/home/data/models/todo_model.dart';
import 'package:task_manager/features/home/data/models/todos.dart';
import 'package:task_manager/features/home/domain/repos/home_repo.dart';

class HomeUseCase {
  final HomeRepo homeRepo;

  HomeUseCase(this.homeRepo);

  @override
  Future<Either<Failure, TodoModel>> getData(int page) async {
    return await homeRepo.getTasks(page);
  }

  Future<Either<Failure, Todos>> addTask(Todos todo) async {
    return await homeRepo.addTask(todo);
  }
}
