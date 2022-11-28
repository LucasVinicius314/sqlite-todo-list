import 'package:flutter/material.dart';
import 'package:sqlite_todo_list/tarefa.dart';

class DialogDeCriarTarefa extends StatefulWidget {
  const DialogDeCriarTarefa({Key? key}) : super(key: key);

  @override
  State<DialogDeCriarTarefa> createState() => _DialogDeCriarTarefaState();
}

class _DialogDeCriarTarefaState extends State<DialogDeCriarTarefa> {
  final _controller = TextEditingController();

  Future<void>? _futureCriarTarefa;

  void _criarTarefa(String tarefa) async {
    setState(() {
      _futureCriarTarefa = Tarefa.criarTarefa(tarefa);
    });

    await _futureCriarTarefa;

    if (mounted) {
      Navigator.of(context).maybePop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _futureCriarTarefa,
      builder: (context, snapshot) {
        return AlertDialog(
          title: const Text('Criar nova tarefa'),
          content: TextFormField(
            enabled: snapshot.connectionState != ConnectionState.waiting,
            decoration: const InputDecoration(labelText: 'Tarefa'),
            controller: _controller,
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                _criarTarefa(_controller.text);
              },
              child: const Text('Criar tarefa'),
            ),
          ],
        );
      },
    );
  }
}
