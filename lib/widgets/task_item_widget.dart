import 'package:flutter/material.dart';
import 'package:flutter_mastering_course/core/theme/theme_controller.dart';
import 'package:flutter_mastering_course/core/widgets/custom_check_box.dart';
import 'package:flutter_mastering_course/core/enums/task_item_actions_enum.dart';
import 'package:flutter_mastering_course/model/task_model.dart';

class TaskItemWidget extends StatelessWidget {
  TaskItemWidget({
    super.key,
    required this.model,
    required this.onChanged,
    required this.onDelete,
  });
  TaskModel model;
  final Function(bool?) onChanged;
  final Function(int id) onDelete;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 56,
      width: double.infinity,

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Theme.of(context).colorScheme.primaryContainer,
        border: Border.all(
          color: ThemeController.isDark()
              ? Colors.transparent
              : const Color(0xFFD1DAD6),
        ),
      ),
      child: Row(
        children: [
          const SizedBox(width: 8),
          CustomCheckBox(
            value: model.isDone,
            onChanged: (bool? value) => onChanged(value),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.taskName,
                  style: TextStyle(
                    color: model.isDone
                        ? Theme.of(context).colorScheme.secondary
                        : Theme.of(context).colorScheme.primary,
                    fontSize: 16,
                    decoration: model.isDone
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                    decorationColor: const Color(0xFFA0A0A0),
                    overflow: TextOverflow.ellipsis,
                  ),
                  maxLines: 1,
                ),
                Text(
                  model.taskDescription,
                  style: const TextStyle(
                    color: Color(0xFC6C6C6F),
                    fontSize: 14,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          PopupMenuButton<TaskItemActionsEnum>(
            icon: Icon(
              Icons.more_vert,
              color: ThemeController.isDark()
                  ? (model.isDone
                        ? const Color(0xFFA0A0A0)
                        : const Color(0xFFC6C6C6))
                  : (model.isDone
                        ? const Color(0xFF6A6A6A)
                        : const Color(0XFF3A4640)),
            ),
            onSelected: (value) {
              switch (value) {
                case TaskItemActionsEnum.markIsDone:
                  onChanged(!model.isDone);
                case TaskItemActionsEnum.edit:
                  // TODO: Handle this case.
                  throw UnimplementedError();
                case TaskItemActionsEnum.delete:
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('Delete Task'),
                        titleTextStyle: Theme.of(
                          context,
                        ).textTheme.displayLarge,
                        backgroundColor: Theme.of(
                          context,
                        ).scaffoldBackgroundColor,
                        contentTextStyle: Theme.of(
                          context,
                        ).textTheme.titleSmall,
                        content: Text(
                          'Are you sure you want to delete this task?',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              onDelete(model.id);
                              Navigator.pop(context);
                            },
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.red,
                            ),
                            child: Text('Delete'),
                          ),
                        ],
                      );
                    },
                  );
              }
            },
            itemBuilder: (context) => TaskItemActionsEnum.values.map((e) {
              return PopupMenuItem<TaskItemActionsEnum>(
                value: e,
                child: Text(e.name),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
