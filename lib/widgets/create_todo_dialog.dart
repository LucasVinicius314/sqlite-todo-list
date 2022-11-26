import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqlite_todo_list/blocs/todo/todo_bloc.dart';
import 'package:sqlite_todo_list/blocs/todo/todo_event.dart';
import 'package:sqlite_todo_list/blocs/todo/todo_state.dart';

class CreateTodoDialog extends StatelessWidget {
  CreateTodoDialog({Key? key}) : super(key: key);

  final _focusNode = FocusNode();
  final _controller = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TodoBloc, TodoState>(
      listener: (context, state) {
        if (state is CreateTodoDoneState) {
          Navigator.of(context).maybePop();
        }
      },
      builder: (context, state) {
        final isLoading = state is CreateTodoLoadingState;

        return AlertDialog(
          title: const Text('Create new todo'),
          content: Form(
            key: _formKey,
            child: TextFormField(
              enabled: !isLoading,
              focusNode: _focusNode,
              controller: _controller,
              decoration: const InputDecoration(labelText: 'Title'),
              validator: (value) {
                value ??= '';

                if (value.trim().length < 3) {
                  return 'Title too short.';
                }

                return null;
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: isLoading
                  ? null
                  : () {
                      if (_formKey.currentState?.validate() != true) {
                        return;
                      }

                      BlocProvider.of<TodoBloc>(context)
                          .add(CreateTodoEvent(title: _controller.text.trim()));
                    },
              child: const Text('Create'),
            ),
          ],
        );
      },
    );
  }
}
