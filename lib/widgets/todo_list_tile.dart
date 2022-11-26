import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqlite_todo_list/blocs/todo/todo_bloc.dart';
import 'package:sqlite_todo_list/blocs/todo/todo_event.dart';
import 'package:sqlite_todo_list/models/todo.dart';

class TodoListTile extends StatelessWidget {
  const TodoListTile({Key? key, required this.todo}) : super(key: key);

  final Todo todo;

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      contentPadding: EdgeInsets.symmetric(
        vertical: 16.0,
        horizontal: 16.0,
      ),
      value: todo.getIsChecked,
      visualDensity: VisualDensity.comfortable,
      title: Text(
        todo.getTitle,
        style: Theme.of(context).textTheme.subtitle2,
      ),
      controlAffinity: ListTileControlAffinity.leading,
      onChanged: (value) {
        if (value == null) {
          return;
        }

        BlocProvider.of<TodoBloc>(context)
            .add(CheckTodoEvent(id: todo.getId, isChecked: value));
      },
      secondary: IconButton(
        tooltip: 'Delete todo',
        color: Colors.redAccent,
        icon: const Icon(Icons.delete),
        onPressed: () {
          BlocProvider.of<TodoBloc>(context)
              .add(DeleteTodoEvent(id: todo.getId));
        },
      ),
    );
  }
}
