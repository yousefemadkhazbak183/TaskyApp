import 'package:flutter/material.dart';
import 'package:flutter_mastering_course/core/constants/app_sizes.dart';
import 'package:flutter_mastering_course/core/services/hive_storage_manager.dart';
import 'package:flutter_mastering_course/core/theme/theme_controller.dart';
import 'package:flutter_mastering_course/core/widgets/custom_check_box.dart';
import 'package:flutter_mastering_course/core/enums/task_item_actions_enum.dart';
import 'package:flutter_mastering_course/core/widgets/custom_text_form_field.dart';
import 'package:flutter_mastering_course/model/task_model.dart';

// ignore: must_be_immutable
class TaskItemWidget extends StatelessWidget {
  TaskItemWidget({
    super.key,
    required this.model,
    required this.onChanged,
    required this.onDelete,
    required this.onEdit,
  });
  TaskModel model;
  final Function(bool?) onChanged;
  final Function(int id) onDelete;
  final Function onEdit;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: AppSizes.h56,
      width: double.infinity,

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSizes.r20),
        color: Theme.of(context).colorScheme.primaryContainer,
        border: Border.all(
          color: ThemeController.isDark() ? Colors.transparent : const Color(0xFFD1DAD6),
        ),
      ),
      child: Row(
        children: [
          SizedBox(width: AppSizes.w8),
          CustomCheckBox(
            value: model.isDone,
            onChanged: (bool? value) => onChanged(value),
          ),
          SizedBox(width: AppSizes.w16),
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
                    fontSize: AppSizes.sp16,
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
                  style: TextStyle(
                    color: const Color(0xFC6C6C6F),
                    fontSize: AppSizes.sp14,
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
                  ? (model.isDone ? const Color(0xFFA0A0A0) : const Color(0xFFC6C6C6))
                  : (model.isDone ? const Color(0xFF6A6A6A) : const Color(0XFF3A4640)),
            ),
            onSelected: (value) async {
              switch (value) {
                case TaskItemActionsEnum.markIsDone:
                  onChanged(!model.isDone);
                case TaskItemActionsEnum.edit:
                  final result = await _showButtonSheet(context, model);
                  if (result == true) {
                    onEdit();
                  }
                case TaskItemActionsEnum.delete:
                  await _showAlertDialog(context);
              }
            },
            itemBuilder: (context) => TaskItemActionsEnum.values.map((e) {
              return PopupMenuItem<TaskItemActionsEnum>(value: e, child: Text(e.name));
            }).toList(),
          ),
        ],
      ),
    );
  }

  Future<String?> _showAlertDialog(context) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Task'),
          titleTextStyle: Theme.of(context).textTheme.displayLarge,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          contentTextStyle: Theme.of(context).textTheme.titleSmall,
          content: const Text('Are you sure you want to delete this task?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                onDelete(model.id);
                Navigator.pop(context);
              },
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  Future<bool?> _showButtonSheet(BuildContext context, TaskModel model) {
    final TextEditingController addTaskController = TextEditingController(
      text: model.taskName,
    );
    final TextEditingController addTaskDescriptionController = TextEditingController(
      text: model.taskDescription,
    );

    final GlobalKey<FormState> key = GlobalKey<FormState>();
    bool isHighPriority = false;

    return showModalBottomSheet<bool>(
      context: context,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, void Function(void Function()) setState) {
            return Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppSizes.ph16,
                vertical: AppSizes.ph8,
              ),
              child: Form(
                key: key,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: AppSizes.ph8),
                    CustomTextFormField(
                      title: 'Task Name',
                      controller: addTaskController,
                      hintText: 'Finish UI design for login screen',
                      validator: (String? value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter task name';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: AppSizes.h20),
                    CustomTextFormField(
                      title: 'Task Description',
                      controller: addTaskDescriptionController,
                      hintText:
                          'Finish onboarding UI and hand off to \n devs by Thursday.',
                      maxLines: 5,
                    ),
                    SizedBox(height: AppSizes.h20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'High Priority',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Switch(
                          value: isHighPriority,

                          onChanged: (bool value) {
                            setState(() {
                              isHighPriority = value;
                            });
                          },
                        ),
                      ],
                    ),

                    // Spacer(),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(MediaQuery.of(context).size.width, AppSizes.h40),
                      ),
                      onPressed: () async {
                        if (key.currentState?.validate() ?? false) {
                          final List<TaskModel> listTask = HiveStorageManager()
                              .loadTask();

                          final TaskModel newModel = TaskModel(
                            id: model.id,
                            taskName: addTaskController.text,
                            taskDescription: addTaskDescriptionController.text,
                            isHighPriority: isHighPriority,
                            isDone: model.isDone,
                          );

                          final item = listTask.firstWhere((e) => e.id == model.id);
                          final int index = listTask.indexOf(item);
                          listTask[index] = newModel;

                          await HiveStorageManager().saveTasks(listTask);

                          Navigator.of(context).pop(true);
                        }
                      },
                      label: const Text('Edit Task'),
                      icon: const Icon(Icons.edit),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
