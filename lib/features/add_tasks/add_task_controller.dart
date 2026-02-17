import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_mastering_course/core/constants/storage_keys.dart';
import 'package:flutter_mastering_course/core/services/file_storage_manager.dart';
import 'package:flutter_mastering_course/core/services/preferences_manager.dart';
import 'package:flutter_mastering_course/model/task_model.dart';

class AddTaskController with ChangeNotifier {
  final GlobalKey<FormState> key = GlobalKey<FormState>();

  final TextEditingController addTaskController = TextEditingController();

  final TextEditingController addTaskDescriptionController =
      TextEditingController();

  bool isHighPriority = true;
  void addTask(BuildContext context) async {
    if (key.currentState?.validate() ?? false) {
      final taskJson = PreferencesManager().getString(StorageKeys.task);

      List<dynamic> listTask = [];
      if (taskJson != null) {
        listTask = jsonDecode(taskJson);
      }
      final TaskModel model = TaskModel(
        id: listTask.length + 1,
        taskName: addTaskController.text,
        taskDescription: addTaskDescriptionController.text,
        isHighPriority: isHighPriority,
      );

      listTask.add(model.toJson());
      await FileStorageManager().saveTasks(listTask);

      final taskEncode = jsonEncode(listTask);
      await PreferencesManager().setString(StorageKeys.task, taskEncode);
      Navigator.of(context).pop(true);
    }
  }

  void toggle(bool value) {
    isHighPriority = value;
    notifyListeners();
  }
}
