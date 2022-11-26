import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqlite_todo_list/blocs/todo/todo_bloc.dart';
import 'package:sqlite_todo_list/blocs/todo/todo_event.dart';
import 'package:sqlite_todo_list/blocs/todo/todo_state.dart';
import 'package:sqlite_todo_list/widgets/loading_indicator.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    BlocProvider.of<TodoBloc>(context).add(ListTodosEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: BlocBuilder<TodoBloc, TodoState>(
        builder: (context, state) {
          if (state is ListTodosErrorState) {
            return const Text('Something went wrong.');
          }

          if (state is ListTodosDoneState) {
            final todos = state.todos;

            return ListView.separated(
              itemBuilder: (context, index) {
                final item = todos[index];

                return CheckboxListTile(
                  value: item.isChecked,
                  visualDensity: VisualDensity.comfortable,
                  title: Text(
                    item.title,
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  controlAffinity: ListTileControlAffinity.leading,
                  onChanged: (value) {},
                  secondary: IconButton(
                    tooltip: 'Delete todo',
                    color: Colors.redAccent,
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      // TODO: fix
                    },
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const Divider(
                  height: 0.0,
                  indent: 64.0,
                );
              },
              itemCount: todos.length,
            );
          }

          return const LoadingIndicator();
        },
      ),
    );
  }
}
