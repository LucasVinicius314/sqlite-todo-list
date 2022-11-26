class TodoEvent {}

class CheckTodoEvent extends TodoEvent {
  CheckTodoEvent({required this.id, required this.isChecked});

  final int id;
  final bool isChecked;
}

class CreateTodoEvent extends TodoEvent {
  CreateTodoEvent({required this.title});

  final String title;
}

class DeleteTodoEvent extends TodoEvent {
  DeleteTodoEvent({required this.id});

  final int id;
}

class ListTodosEvent extends TodoEvent {}
