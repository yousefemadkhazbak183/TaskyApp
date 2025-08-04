import 'package:flutter/material.dart';
import 'package:flutter_mastering_course/model/task_model.dart';
import 'package:flutter_mastering_course/widgets/task_item_widget.dart';

class TaskListWidgets extends StatelessWidget {
  const TaskListWidgets({
    super.key,
    required this.tasks,
    required this.onTap,
    this.emptyMessage,
  });

  final List<TaskModel> tasks;
  final Function(bool?, int?) onTap;
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
            padding: EdgeInsets.only(bottom: 40),
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: TaskItemWidget(
                  model: tasks[index],
                  onChanged: (bool? value) {
                    onTap(value, index);
                  },
                ),
              );
            },
            itemCount: tasks.length,
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(height: 8);
            },
          );
  }
}
