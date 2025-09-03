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
  int totalTasks = 0;
  int totalDoneTasks = 0;
  double percent = 0;

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

      _loadData();

      _calculatePercent();
    }

    isLoading = false;
    notifyListeners();
  }

  void _loadData() {
    todoTasks = myTasks.where((element) => !element.isDone).toList();
    completeTasks = myTasks.where((element) => element.isDone).toList();
    highPriorityTasks = myTasks
        .where((element) => element.isHighPriority)
        .toList();
    highPriorityTasks = highPriorityTasks.reversed.toList();
  }

  /// [deleteTask]
  void deleteTask(int? id) async {
    if (id == null) return;

    myTasks.removeWhere((e) => e.id == id);

    _loadData();
    _calculatePercent();
    final updatedTask = myTasks.map((element) => element.toJson()).toList();
    await PreferencesManager().setString(
      StorageKeys.task,
      jsonEncode(updatedTask),
    );

    notifyListeners();
  }

  // [doneTasks]
  void doneTasks(bool? value, int id) async {
    final index = myTasks.indexWhere((e) => e.id == id);
    myTasks[index].isDone = value ?? false;
    _loadData();
    _calculatePercent();
    final updatedTask = myTasks.map((e) => e.toJson()).toList();
    PreferencesManager().setString(StorageKeys.task, jsonEncode(updatedTask));

    notifyListeners();
  }

  void _calculatePercent() {
    totalTasks = myTasks.length;
    totalDoneTasks = myTasks.where((element) => element.isDone).length;
    percent = totalDoneTasks == 0 ? 0 : totalDoneTasks / totalTasks;

    notifyListeners();
  }
}
