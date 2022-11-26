import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqlite_todo_list/blocs/todo/todo_bloc.dart';
import 'package:sqlite_todo_list/blocs/todo/todo_event.dart';
import 'package:sqlite_todo_list/blocs/todo/todo_state.dart';
import 'package:sqlite_todo_list/utils/sqlite.dart';
import 'package:sqlite_todo_list/widgets/create_todo_dialog.dart';
import 'package:sqlite_todo_list/widgets/loading_indicator.dart';
import 'package:sqlite_todo_list/widgets/todo_list_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<void> _createTodo() async {
    await showDialog(
      context: context,
      builder: (context) {
        return CreateTodoDialog();
      },
    );
  }

  @override
  void initState() {
    super.initState();

    SQLite.setup();

    BlocProvider.of<TodoBloc>(context).add(ListTodosEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: BlocConsumer<TodoBloc, TodoState>(
        listener: (context, state) {
          switch (state.runtimeType) {
            case CheckTodoDoneState:
            case CreateTodoDoneState:
            case DeleteTodoDoneState:
              BlocProvider.of<TodoBloc>(context).add(ListTodosEvent());

              break;
          }
        },
        builder: (context, state) {
          if (state is ListTodosErrorState) {
            return const Text('Something went wrong.');
          }

          if (state is ListTodosDoneState) {
            final todos = state.todos;

            if (todos.isEmpty) {
              return Padding(
                padding: const EdgeInsets.all(64.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'No todos have been found. Try creating a new one!',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ],
                ),
              );
            }

            return ListView.separated(
              itemBuilder: (context, index) {
                return TodoListTile(todo: todos[index]);
              },
              separatorBuilder: (context, index) {
                return const Divider(height: 0.0, indent: 64.0);
              },
              itemCount: todos.length,
            );
          }

          return const LoadingIndicator();
        },
      ),
      floatingActionButton: BlocBuilder<TodoBloc, TodoState>(
        builder: (context, state) {
          final enabled = state is ListTodosDoneState;

          return FloatingActionButton(
            tooltip: 'Create new todo',
            onPressed: enabled ? _createTodo : null,
            child: const Icon(Icons.add),
          );
        },
      ),
    );
  }
}
