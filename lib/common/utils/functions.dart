import 'dart:convert';

import 'package:task_manager/common/utils/cache_helper.dart';
import 'package:task_manager/features/home/data/models/todos.dart';

void saveLocalTasksData(List<Todos> newTasks) async {
  String? cachedTasksJson = CacheHelper.getData(key: "cachedTasks");

  List<Todos> combinedTasks = [];

  // if there are tasks , decode them and add to the  list
  if (cachedTasksJson != null) {
    List<dynamic> decodedJson = json.decode(cachedTasksJson);
    List<Todos> cachedTasks =
        decodedJson.map((task) => Todos.fromJson(task)).toList();
    combinedTasks.addAll(cachedTasks);
  }

  // add new tasks
  combinedTasks.addAll(newTasks);

  // convert  to json and store in sharedpref
  List<Map<String, dynamic>> tasksJson =
      combinedTasks.map((task) => task.toJson()).toList();
  CacheHelper.saveData(key: "cachedTasks", value: json.encode(tasksJson));
}
