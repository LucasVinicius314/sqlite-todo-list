import 'package:flutter/material.dart';
import 'package:sqlite_todo_list/core/bloc_providers.dart';
import 'package:sqlite_todo_list/core/repository_providers.dart';
import 'package:sqlite_todo_list/modules/home_page.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProviders(
      child: BlocProviders(
        child: MaterialApp(
          home: const HomePage(),
          theme: ThemeData.dark(),
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}
