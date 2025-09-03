import 'package:flutter/material.dart';

import 'package:flutter_mastering_course/core/components/task_list_widgets.dart';
import 'package:flutter_mastering_course/features/tasks/controllers/tasks_controller.dart';

import 'package:provider/provider.dart';

class HighPriorityScreen extends StatelessWidget {
  const HighPriorityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.read<TasksController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('High Priority Tasks'),
        centerTitle: false,
      ),

      body: Padding(
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
                        tasks: value.highPriorityTasks,
                        onTap: (value, index) async {
                          controller.highPriorityDoneTasks(value, index);
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
    );
  }
}
