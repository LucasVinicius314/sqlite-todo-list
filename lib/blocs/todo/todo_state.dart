import 'package:sqlite_todo_list/models/todo.dart';

class TodoState {}

class TodoInitialState extends TodoState {}

// ListTodos

class ListTodosLoadingState extends TodoState {}

class ListTodosDoneState extends TodoState {
  ListTodosDoneState({required this.todos});

  final List<Todo> todos;
}

class ListTodosErrorState extends TodoState {}
