import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_mastering_course/core/constants/storage_keys.dart';
import 'package:flutter_mastering_course/core/services/preferences_manager.dart';
import 'package:flutter_mastering_course/model/task_model.dart';

class TasksController with ChangeNotifier {
  bool isLoading = false;

  List<TaskModel> myTasks = [];
  List<TaskModel> todoTasks = [];
  List<TaskModel> completeTasks = [];
  List<TaskModel> highPriorityTasks = [];

  TasksController() {
    init();
  }

  void init() {
    _loadTasks();
  }

  ///[_loadTasks]
  void _loadTasks() {
    isLoading = true;

    final finalTasks = PreferencesManager().getString(StorageKeys.task);
    if (finalTasks != null) {
      final taskAfterDecode = jsonDecode(finalTasks) as List<dynamic>;

      myTasks = taskAfterDecode.map((e) => TaskModel.fromJson(e)).toList();
      todoTasks = myTasks.where((element) => !element.isDone).toList();
      completeTasks = myTasks.where((element) => element.isDone).toList();

      highPriorityTasks = taskAfterDecode
          .map((e) => TaskModel.fromJson(e))
          .where((element) => element.isHighPriority)
          .toList()
          .reversed
          .toList();

      // calculatePercent();
    }

    isLoading = false;
    notifyListeners();
  }

  /// [deleteTask]
  void deleteTask(int? id) async {
    if (id == null) return;

    myTasks.removeWhere((e) => e.id == id);

    todoTasks.removeWhere((task) => task.id == id);

    completeTasks.removeWhere((task) => task.id == id);
    highPriorityTasks.removeWhere((task) => task.id == id);

    final updatedTask = myTasks.map((element) => element.toJson()).toList();
    await PreferencesManager().setString(
      StorageKeys.task,
      jsonEncode(updatedTask),
    );

    notifyListeners();
  }

  // [doneTasks]
  void doneTasks(bool? value, int? index) async {
    if (index == null) return;
    todoTasks[index].isDone = value ?? false;

    final int newIndex = myTasks.indexWhere((e) => e.id == todoTasks[index].id);

    myTasks[newIndex] = todoTasks[index];
    await PreferencesManager().setString(StorageKeys.task, jsonEncode(myTasks));
    _loadTasks();
  }

  //[doneCompleteTasks]
  void doneCompleteTasks(bool? value, int? index) async {
    if (index == null) return;
    completeTasks[index].isDone = value ?? false;

    final int newIndex = myTasks.indexWhere(
      (e) => e.id == completeTasks[index].id,
    );

    myTasks[newIndex] = completeTasks[index];
    await PreferencesManager().setString(StorageKeys.task, jsonEncode(myTasks));

    completeTasks[index].isDone = value ?? false;

    myTasks[newIndex] = completeTasks[index];
    await PreferencesManager().setString(StorageKeys.task, jsonEncode(myTasks));

    _loadTasks();
  }

  /// [HighPriorityDoneTasks]
  void highPriorityDoneTasks(bool? value, int? index) async {
    if (index == null) return;
    highPriorityTasks[index].isDone = value ?? false;

    final int newIndex = myTasks.indexWhere(
      (e) => e.id == highPriorityTasks[index].id,
    );

    myTasks[newIndex] = highPriorityTasks[index];
    await PreferencesManager().setString(StorageKeys.task, jsonEncode(myTasks));

    highPriorityTasks[index].isDone = value ?? false;

    myTasks[newIndex] = highPriorityTasks[index];
    await PreferencesManager().setString(StorageKeys.task, jsonEncode(myTasks));

    _loadTasks();
  }
}
