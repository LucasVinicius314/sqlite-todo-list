import 'package:flutter/material.dart';
import 'package:sqlite_todo_list/pagina_principal.dart';

void main() {
  runApp(const Aplicativo());
}

class Aplicativo extends StatelessWidget {
  const Aplicativo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: PaginaPrincipal(),
      debugShowCheckedModeBanner: false,
    );
  }
}
