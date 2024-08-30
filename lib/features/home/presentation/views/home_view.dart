import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/common/utils/cache_helper.dart';
import 'package:task_manager/common/widgets/no-data_found.dart';
import 'package:task_manager/features/home/data/models/todos.dart';
import 'package:task_manager/features/home/presentation/controller/home_cubit/home_cubit.dart';
import 'package:task_manager/features/home/presentation/controller/home_cubit/home_state.dart';
import 'package:task_manager/features/home/presentation/widgets/add_task_alert.dart';
import 'package:task_manager/features/home/presentation/widgets/shimmer_list.dart';
import 'package:task_manager/features/home/presentation/widgets/todo_item.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late final ScrollController scrollController;
  int nextPage = 1;
  bool isLoading = false;
  bool lastCurrentPageItem = false;
  bool noMoreData = false;
  @override
  void initState() {
    scrollController = ScrollController();
    scrollController.addListener(scrollListener);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await HomeCubit.get(context).getTasks(0);
    });
    super.initState();
  }

  void scrollListener() async {
    var currentPosition = scrollController.position.pixels;

    var maxScrollLength = scrollController.position.maxScrollExtent;

    if (currentPosition >= maxScrollLength) {
      if (!isLoading) {
        isLoading = true;
        await HomeCubit.get(context).getTasks((nextPage++) * 10);
        isLoading = false;
      }
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  List<Todos> todos = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text('tasks'),
      ),
      body: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          if (state is GetTasksSuccessState) {
            int total = state.tasks.total!; //254

            todos.addAll(state.tasks.todos!);
            if (todos.length == total) {
              noMoreData = true;
            }
          }

          if (state is GetTasksPaginationErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                backgroundColor: Colors.red,
                duration: const Duration(seconds: 3),
                content: Text(
                  state.errMessage,
                  style: const TextStyle(color: Colors.white),
                )));
          }
          if (state is GetTasksPaginationLoading) {
            lastCurrentPageItem = true;
          }
        },
        builder: (context, state) {
          return (state is GetTasksSuccessState ||
                  state is GetTasksPaginationLoading ||
                  state is GetTasksPaginationErrorState)
              ? todos.isEmpty
                  ? const Center(
                      child: SizedBox(
                          height: 70,
                          child: NoDataFoundWidget(
                            title: 'no content',
                          )),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ListView.builder(
                        controller: scrollController,
                        shrinkWrap: true,
                        itemCount: lastCurrentPageItem
                            ? todos.length + 1
                            : todos.length,
                        itemBuilder: (BuildContext context, int index) {
                          return lastCurrentPageItem &&
                                  index == todos.length &&
                                  !noMoreData
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : noMoreData && index == todos.length
                                  ? const Center(child: Text("no more data"))
                                  : TodoItem(todos![index]);
                        },
                      ),
                    )
              : (state is GetTasksErrorState)
                  ? Center(child: Text(state.errMessage.toString()))
                  : ListView.builder(
                      controller: scrollController,
                      itemCount: 5,
                      itemBuilder: (context, i) {
                        return const ShimmerList();
                      });
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AddTodoDialog();
            },
          );
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
      ),
    );
  }
}
