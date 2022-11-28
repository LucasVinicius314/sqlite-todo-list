import 'package:flutter/material.dart';
import 'package:sqlite_todo_list/tarefa.dart';

class WidgetTarefa extends StatelessWidget {
  const WidgetTarefa({
    Key? key,
    required this.tarefa,
    required this.atualizar,
  }) : super(key: key);

  final Tarefa tarefa;
  final Function atualizar;

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      value: tarefa.concluida == 1,
      title: Text(tarefa.tarefa ?? ''),
      controlAffinity: ListTileControlAffinity.leading,
      secondary: IconButton(
        icon: const Icon(Icons.delete),
        tooltip: 'Excluir tarefa',
        color: Colors.red,
        onPressed: () async {
          await Tarefa.excluirTarefa(tarefa.id ?? 0);

          atualizar();
        },
      ),
      onChanged: (value) async {
        if (value != null) {
          await Tarefa.marcarTarefa(tarefa.id ?? 0, value);

          atualizar();
        }
      },
    );
  }
}
