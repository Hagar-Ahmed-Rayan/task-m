import 'todos.dart';

class TodoModel {
  TodoModel({
    this.todos,
    this.total,
    this.skip,
    this.limit,
  });

  TodoModel.fromJson(dynamic json) {
    if (json['todos'] != null) {
      todos = [];
      json['todos'].forEach((v) {
        todos?.add(Todos.fromJson(v));
      });
    }
    total = json['total'];
    skip = json['skip'];
    limit = json['limit'];
  }
  List<Todos>? todos;
  int? total;
  num? skip;
  num? limit;
  TodoModel copyWith({
    List<Todos>? todos,
    int? total,
    num? skip,
    num? limit,
  }) =>
      TodoModel(
        todos: todos ?? this.todos,
        total: total ?? this.total,
        skip: skip ?? this.skip,
        limit: limit ?? this.limit,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (todos != null) {
      map['todos'] = todos?.map((v) => v.toJson()).toList();
    }
    map['total'] = total;
    map['skip'] = skip;
    map['limit'] = limit;
    return map;
  }
}
