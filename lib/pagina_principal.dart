import 'package:flutter/material.dart';
import 'package:sqlite_todo_list/tarefa.dart';
import 'package:sqlite_todo_list/banco.dart';
import 'package:sqlite_todo_list/dialog_de_criar_tarefa.dart';
import 'package:sqlite_todo_list/widget_tarefa.dart';

class PaginaPrincipal extends StatefulWidget {
  const PaginaPrincipal({Key? key}) : super(key: key);

  @override
  State<PaginaPrincipal> createState() => _PaginaPrincipalState();
}

class _PaginaPrincipalState extends State<PaginaPrincipal> {
  Future<List<Tarefa>>? _futureDeListarTarefas;

  void _atualizar() async {
    setState(() {
      _futureDeListarTarefas = Tarefa.listarTarefas();
    });
  }

  void _criarTarefa() async {
    await showDialog(
      context: context,
      builder: (context) {
        return const DialogDeCriarTarefa();
      },
    );

    _atualizar();
  }

  @override
  void initState() {
    super.initState();

    Banco.criarBanco();

    _atualizar();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Alpicativo SQLite'),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Criar tarefa',
        onPressed: _criarTarefa,
        child: const Icon(Icons.add),
      ),
      body: FutureBuilder<List<Tarefa>>(
        future: _futureDeListarTarefas,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            var tarefas = snapshot.data ?? [];

            return ListView.builder(
              itemCount: tarefas.length,
              itemBuilder: (context, index) {
                return WidgetTarefa(
                  tarefa: tarefas[index],
                  atualizar: _atualizar,
                );
              },
            );
          }

          return const CircularProgressIndicator();
        },
      ),
    );
  }
}
