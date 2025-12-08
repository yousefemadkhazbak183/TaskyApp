import 'package:flutter/material.dart';
import 'package:flutter_mastering_course/core/constants/app_sizes.dart';
import 'package:flutter_mastering_course/model/task_model.dart';
import 'package:flutter_mastering_course/core/components/task_item_widget.dart';

class TaskListWidgets extends StatelessWidget {
  const TaskListWidgets({
    super.key,
    required this.tasks,
    required this.onTap,
    this.emptyMessage,
    required this.onDelete,
    required this.onEdit,
  });

  final List<TaskModel> tasks;
  final Function(bool?, int?) onTap;
  final Function(int id) onDelete;
  final Function onEdit;
  final String? emptyMessage;

  @override
  Widget build(BuildContext context) {
    return tasks.isEmpty
        ? Center(
            child: Text(
              emptyMessage ?? 'No Data',
              style: Theme.of(context).textTheme.displayLarge,
            ),
          )
        : ListView.separated(
            padding: EdgeInsets.only(bottom: AppSizes.h40),
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: EdgeInsets.only(top: AppSizes.h8),
                child: TaskItemWidget(
                  model: tasks[index],
                  onChanged: (bool? value) {
                    onTap(value, index);
                  },
                  onDelete: (int id) {
                    onDelete(id);
                  },
                  onEdit: () {
                    onEdit();
                  },
                ),
              );
            },
            itemCount: tasks.length,
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(height: AppSizes.h8);
            },
          );
  }
}
