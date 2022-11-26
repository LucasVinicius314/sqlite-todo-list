import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqlite_todo_list/blocs/todo/todo_event.dart';
import 'package:sqlite_todo_list/blocs/todo/todo_state.dart';
import 'package:sqlite_todo_list/repositories/todo_repository.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc({required this.todoRepository}) : super(TodoInitialState()) {
    on<ListTodosEvent>(_listTodos);
  }

  final TodoRepository todoRepository;

  Future<void> _listTodos(ListTodosEvent event, Emitter<TodoState> emit) async {
    try {
      emit(ListTodosLoadingState());

      final todos = await todoRepository.listTodos();

      emit(ListTodosDoneState(todos: todos));
    } catch (e) {
      emit(ListTodosErrorState());
    }
  }
}
