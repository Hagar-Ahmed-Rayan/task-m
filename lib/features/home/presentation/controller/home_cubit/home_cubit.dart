import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:task_manager/common/utils/cache_helper.dart';
import 'package:task_manager/features/home/data/models/todos.dart';
import 'package:task_manager/features/home/domain/usecases/home_usecase.dart';
import 'package:task_manager/features/home/presentation/controller/home_cubit/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.homeUseCase) : super(HomeInitial());

  static HomeCubit get(context) => BlocProvider.of(context);
  bool isCompleted = false;

  final HomeUseCase homeUseCase;

  final pagingController = PagingController<int, Todos>(
    firstPageKey: 0,
  );
  Future<void> getTasks(int page) async {
    if (page == 0)
      emit(GetTasksLoading());
    else {
      emit(GetTasksPaginationLoading());
    }

    var result = await homeUseCase.getData(page);
    result.fold((failure) {
      if (page == 0) {
        emit(GetTasksErrorState(failure.message));
      } else {
        emit(GetTasksPaginationErrorState(failure.message));
      }
    }, (todoModel) {
      int total = todoModel.total!; //254
      if (page >= total) {
        todoModel.todos = [];
      }

      emit(GetTasksSuccessState(todoModel));
    });
  }

  Future<void> addTask(String text) async {
    String? userId = CacheHelper.getData(key: 'userId');
    Todos task = Todos(
      completed: isCompleted,
      userId: num.parse(userId!),
      todo: text,
    );
    emit(AddTaskLoadingState());

    var result = await homeUseCase.addTask(task);
    result.fold((failure) {
      emit(AddTaskErrorState(failure.message));
    }, (task) async {
      emit(AddTaskSuccessState(task));
      await getTasks(0);
    });
  }

  void toggleCompleteTask(bool value) {
    isCompleted = value;
    emit(ToggleTaskCompleteState());
  }
}
