import 'package:flutter/material.dart';

import 'package:flutter_mastering_course/features/tasks/controllers/tasks_controller.dart';
import 'package:provider/provider.dart';

import '../../core/components/task_list_widgets.dart';

class TaskCompletedScreen extends StatelessWidget {
  const TaskCompletedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TasksController>(
      create: (_) => TasksController()..init(),
      builder: (context, child) {
        final controller = context.read<TasksController>();
        return SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Text(
                  'Completed Tasks',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: controller.isLoading
                      ? const Center(
                          child: CircularProgressIndicator(color: Colors.white),
                        )
                      : Consumer<TasksController>(
                          builder:
                              (
                                BuildContext context,
                                TasksController value,
                                Widget? child,
                              ) {
                                return TaskListWidgets(
                                  tasks: value.completeTasks,
                                  onTap: (value, index) async {
                                    controller.doneCompleteTasks(value, index);
                                  },
                                  onDelete: (int id) {
                                    controller.deleteTask(id);
                                  },
                                  onEdit: () {
                                    controller.init();
                                  },
                                );
                              },
                        ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
