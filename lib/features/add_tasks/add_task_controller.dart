import 'package:flutter/material.dart';

import 'package:flutter_mastering_course/core/services/file_storage_manager.dart';

import 'package:flutter_mastering_course/model/task_model.dart';

class AddTaskController with ChangeNotifier {
  final GlobalKey<FormState> key = GlobalKey<FormState>();

  final TextEditingController addTaskController = TextEditingController();

  final TextEditingController addTaskDescriptionController = TextEditingController();

  bool isHighPriority = true;
  void addTask(BuildContext context) async {
    if (key.currentState?.validate() ?? false) {
      final List<dynamic> listTask = await FileStorageManager().loadTask();

      final TaskModel model = TaskModel(
        id: listTask.length + 1,
        taskName: addTaskController.text,
        taskDescription: addTaskDescriptionController.text,
        isHighPriority: isHighPriority,
      );

      listTask.add(model.toJson());
      await FileStorageManager().saveTasks(listTask);

      Navigator.of(context).pop(true);
    }
  }

  void toggle(bool value) {
    isHighPriority = value;
    notifyListeners();
  }
}
