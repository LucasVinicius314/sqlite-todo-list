import 'package:sqlite_todo_list/models/todo.dart';
import 'package:sqlite_todo_list/utils/sqlite.dart';

class TodoRepository {
  Future<void> checkTodo({required int id, required bool isChecked}) async {
    final db = SQLite.getInstance;

    db.prepare('update todos set is_checked = ? where id = ?')
      ..execute([isChecked, id])
      ..dispose();
  }

  Future<void> createTodo({required String title}) async {
    final db = SQLite.getInstance;

    db.prepare('insert into todos (title, is_checked) values (?, ?)')
      ..execute([title, false])
      ..dispose();
  }

  Future<void> deleteTodo({required int id}) async {
    final db = SQLite.getInstance;

    db.prepare('delete from todos where id = ?')
      ..execute([id])
      ..dispose();
  }

  Future<List<Todo>> listTodos() async {
    final db = SQLite.getInstance;

    return db
        .select('select * from todos')
        .map((e) => Todo.fromJson(e))
        .toList();
  }
}
