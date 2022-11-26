import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqlite_todo_list/blocs/todo/todo_bloc.dart';
import 'package:sqlite_todo_list/repositories/todo_repository.dart';

class BlocProviders extends StatelessWidget {
  const BlocProviders({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TodoBloc(
            todoRepository: RepositoryProvider.of<TodoRepository>(context),
          ),
        ),
      ],
      child: child,
    );
  }
}
