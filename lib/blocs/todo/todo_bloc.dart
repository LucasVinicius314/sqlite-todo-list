import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqlite_todo_list/blocs/todo/todo_event.dart';
import 'package:sqlite_todo_list/blocs/todo/todo_state.dart';
import 'package:sqlite_todo_list/repositories/todo_repository.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc({required this.todoRepository}) : super(TodoInitialState()) {
    on<CheckTodoEvent>(_checkTodo);
    on<CreateTodoEvent>(_createTodo);
    on<DeleteTodoEvent>(_deleteTodo);
    on<ListTodosEvent>(_listTodos);
  }

  final TodoRepository todoRepository;

  Future<void> _checkTodo(
    CheckTodoEvent event,
    Emitter<TodoState> emit,
  ) async {
    try {
      emit(CheckTodoLoadingState());

      await todoRepository.checkTodo(id: event.id, isChecked: event.isChecked);

      emit(CheckTodoDoneState());
    } catch (e) {
      emit(CheckTodoErrorState());
    }
  }

  Future<void> _createTodo(
    CreateTodoEvent event,
    Emitter<TodoState> emit,
  ) async {
    try {
      emit(CreateTodoLoadingState());

      await todoRepository.createTodo(title: event.title);

      emit(CreateTodoDoneState());
    } catch (e) {
      emit(CreateTodoErrorState());
    }
  }

  Future<void> _deleteTodo(
    DeleteTodoEvent event,
    Emitter<TodoState> emit,
  ) async {
    try {
      emit(DeleteTodoLoadingState());

      await todoRepository.deleteTodo(id: event.id);

      emit(DeleteTodoDoneState());
    } catch (e) {
      emit(DeleteTodoErrorState());
    }
  }

  Future<void> _listTodos(
    ListTodosEvent event,
    Emitter<TodoState> emit,
  ) async {
    try {
      emit(ListTodosLoadingState());

      final todos = await todoRepository.listTodos();

      emit(ListTodosDoneState(todos: todos));
    } catch (e) {
      emit(ListTodosErrorState());
    }
  }
}
