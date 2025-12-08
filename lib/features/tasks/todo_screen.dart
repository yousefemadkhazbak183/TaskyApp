import 'package:flutter_mastering_course/core/components/task_list_widgets.dart';
import 'package:flutter_mastering_course/core/constants/app_sizes.dart';
import 'package:flutter_mastering_course/features/tasks/controllers/tasks_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TodoScreen extends StatelessWidget {
  const TodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.read<TasksController>();
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(AppSizes.pw18),
            child: Text(
              'To Do Tasks',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),

          Expanded(
            child: Padding(
              padding: EdgeInsets.all(AppSizes.pw16),
              child: controller.isLoading
                  ? const Center(
                      child: CircularProgressIndicator(color: Colors.white),
                    )
                  : Consumer<TasksController>(
                      builder:
                          (
                            BuildContext context,
                            TasksController valueController,
                            Widget? child,
                          ) {
                            return TaskListWidgets(
                              tasks: valueController.todoTasks,
                              onTap: (value, index) {
                                controller.doneTasks(
                                  value,
                                  valueController.todoTasks[index!].id,
                                );
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
  }
}
