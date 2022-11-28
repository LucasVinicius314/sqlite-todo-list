import 'package:sqlite3/sqlite3.dart';

class Banco {
  static Database banco() {
    return sqlite3.open('banco.db');
  }

  static void criarBanco() {
    banco().execute('''
      CREATE TABLE IF NOT EXISTS tarefas (
        id INTEGER NOT NULL PRIMARY KEY,
        tarefa TEXT NOT NULL,
        concluida BOOL NOT NULL
      );
    ''');
  }
}
