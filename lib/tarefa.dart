import 'package:sqlite_todo_list/banco.dart';

class Tarefa {
  Tarefa({
    required this.id,
    required this.tarefa,
    required this.concluida,
  });

  int? id;
  String? tarefa;
  int? concluida;

  static Tarefa fromJson(Map<String, dynamic> json) {
    return Tarefa(
      id: json['id'] as int?,
      tarefa: json['tarefa'] as String?,
      concluida: json['concluida'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'tarefa': tarefa,
      'concluida': concluida,
    };
  }

  static Future<void> criarTarefa(String tarefa) async {
    Banco.banco()
        .prepare('INSERT INTO tarefas (tarefa, concluida) VALUES (?, ?)')
      ..execute([tarefa, false])
      ..dispose();
  }

  static Future<void> excluirTarefa(int id) async {
    Banco.banco().prepare('DELETE FROM tarefas WHERE id = ?')
      ..execute([id])
      ..dispose();
  }

  static Future<List<Tarefa>> listarTarefas() async {
    return Banco.banco().select('SELECT * FROM tarefas').map((e) {
      return Tarefa.fromJson(e);
    }).toList();
  }

  static Future<void> marcarTarefa(int id, bool concluida) async {
    Banco.banco().prepare('UPDATE tarefas SET concluida = ? WHERE id = ?')
      ..execute([concluida, id])
      ..dispose();
  }
}
