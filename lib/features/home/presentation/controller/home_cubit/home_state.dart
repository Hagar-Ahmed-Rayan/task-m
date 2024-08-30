import 'package:task_manager/features/home/data/models/todo_model.dart';
import 'package:task_manager/features/home/data/models/todos.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class GetTasksLoading extends HomeState {}

class GetTasksErrorState extends HomeState {
  final String errMessage;

  GetTasksErrorState(this.errMessage);
}

class GetTasksSuccessState extends HomeState {
  TodoModel tasks;
  GetTasksSuccessState(this.tasks);
}

class GetTasksPaginationErrorState extends HomeState {
  String errMessage;
  GetTasksPaginationErrorState(this.errMessage);
}

class GetTasksPaginationLoading extends HomeState {}

///add task

class AddTaskLoadingState extends HomeState {}

class AddTaskErrorState extends HomeState {
  final String errMessage;

  AddTaskErrorState(this.errMessage);
}

class AddTaskSuccessState extends HomeState {
  Todos task;
  AddTaskSuccessState(this.task);
}

class ToggleTaskCompleteState extends HomeState {
  ToggleTaskCompleteState();
}
