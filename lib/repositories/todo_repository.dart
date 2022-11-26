import 'package:sqlite_todo_list/models/todo.dart';

class TodoRepository {
  Future<List<Todo>> listTodos() async {
    // TODO: fix
    return [
      Todo(id: 0, title: 'AAAAAAA', isChecked: true),
      Todo(id: 1, title: 'Something', isChecked: false),
      Todo(id: 2, title: 'Another something', isChecked: false),
    ];
  }
}
