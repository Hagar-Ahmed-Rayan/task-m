import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/features/home/presentation/controller/home_cubit/home_state.dart';

import '../controller/home_cubit/home_cubit.dart';

class AddTodoDialog extends StatelessWidget {
  final TextEditingController todoController = TextEditingController();

  AddTodoDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final homeCubit = HomeCubit.get(context);

        return AlertDialog(
          title: const Text('Add New Todo'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: todoController,
                decoration: const InputDecoration(
                  labelText: 'Todo',
                ),
              ),
              CheckboxListTile(
                title: const Text('Task Completed'),
                value: homeCubit.isCompleted,
                onChanged: (bool? value) {
                  homeCubit.toggleCompleteTask(value ?? false);
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                homeCubit.addTask(todoController.text);

                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}
