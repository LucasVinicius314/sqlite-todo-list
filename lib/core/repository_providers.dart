import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqlite_todo_list/repositories/todo_repository.dart';

class RepositoryProviders extends StatelessWidget {
  const RepositoryProviders({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => TodoRepository()),
      ],
      child: child,
    );
  }
}
