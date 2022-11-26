import 'package:sqlite3/sqlite3.dart';

class SQLite {
  static Database get getInstance => sqlite3.open('db.db');

  static void setup() {
    final db = getInstance;

    db.execute('''
    create table if not exists todos (
      id integer not null primary key,
      title text not null,
      is_checked bool not null
    );
    ''');
  }
}
