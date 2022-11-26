import 'package:sqlite_todo_list/models/todo.dart';

class TodoState {}

class TodoInitialState extends TodoState {}

// CheckTodo

class CheckTodoLoadingState extends TodoState {}

class CheckTodoDoneState extends TodoState {}

class CheckTodoErrorState extends TodoState {}

// CreateTodo

class CreateTodoLoadingState extends TodoState {}

class CreateTodoDoneState extends TodoState {}

class CreateTodoErrorState extends TodoState {}

// DeleteTodo

class DeleteTodoLoadingState extends TodoState {}

class DeleteTodoDoneState extends TodoState {}

class DeleteTodoErrorState extends TodoState {}

// ListTodos

class ListTodosLoadingState extends TodoState {}

class ListTodosDoneState extends TodoState {
  ListTodosDoneState({required this.todos});

  final List<Todo> todos;
}

class ListTodosErrorState extends TodoState {}
