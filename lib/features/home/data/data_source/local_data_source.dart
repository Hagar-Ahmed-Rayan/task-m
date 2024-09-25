import 'dart:convert';
import 'package:task_manager/common/utils/cache_helper.dart';
import 'package:task_manager/features/home/data/models/todos.dart';

abstract class HomeLocalDataSource {
  List<Todos> fetchFeaturedBooks({int pageNumber = 0});
}

class HomeLocalDataSourceImpl extends HomeLocalDataSource {
  @override
  List<Todos> fetchFeaturedBooks({int pageNumber = 0}) {
    int startIndex = pageNumber;
    int endIndex = (pageNumber + 10);
    String? cachedTasksJson = CacheHelper.getData(key: "cachedTasks");

    if (cachedTasksJson != null) {
      List<dynamic> decodedJson = json.decode(cachedTasksJson);
      List<Todos> todos =
          decodedJson.map((task) => Todos.fromJson(task)).toList();

      if (startIndex >= todos!.length || endIndex > todos!.length) {
        return [];
      }

      return todos!.sublist(startIndex, endIndex);
    }

    return [];
  }
}
