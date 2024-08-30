

import 'package:task_manager/common/api/api_endpoints.dart';
import 'package:task_manager/common/utils/api_service.dart';

import 'package:task_manager/features/home/data/models/todo_model.dart';
import 'package:task_manager/features/home/data/models/todos.dart';

abstract class HomeRemoteDataSource {
  Future<TodoModel> getTasksData(int page );
  Future<Todos> addTask(Todos task );

}

class HomeRemoteDataSourceImpl extends HomeRemoteDataSource {
  final ApiService apiService;

  HomeRemoteDataSourceImpl(this.apiService);
  @override
  Future<TodoModel> getTasksData(int page ) async {
   int limit =10;
    var response = await apiService.get(
        endPoint:"${Endpoints.getTasks}?limit=$limit &skip=$page"
    );
   TodoModel todos =TodoModel.fromJson(response);
    return TodoModel.fromJson(response);
  }

  @override
  Future<Todos> addTask(Todos task) async  {

    var response = await apiService.post(
        endPoint:Endpoints.addTask, data: task.toJson());
    Todos todos =Todos.fromJson(response);
    return Todos.fromJson(response);

  }



}