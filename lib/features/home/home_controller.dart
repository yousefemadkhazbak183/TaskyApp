import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_mastering_course/core/constants/storage_keys.dart';
import 'package:flutter_mastering_course/core/services/preferences_manager.dart';
import 'package:flutter_mastering_course/model/task_model.dart';

class HomeController with ChangeNotifier {
  List<TaskModel> tasksList = [];
  String? username;
  String? userImagePath;
  List<TaskModel> tasks = [];
  bool isLoading = false;
  int totalTasks = 0;

  int totalDoneTasks = 0;

  double percent = 0;

  void init() {
    loadUsername();
    loadTask();
  }

  void loadTask() async {
    isLoading = true;

    final finalTasks = PreferencesManager().getString(StorageKeys.task);
    if (finalTasks != null) {
      final taskAfterDecode = jsonDecode(finalTasks) as List<dynamic>;

      tasks = taskAfterDecode.map((e) => TaskModel.fromJson(e)).toList();
      calculatePercent();
    }

    isLoading = false;
    notifyListeners();
  }

  void loadUsername() async {
    username = PreferencesManager().getString(StorageKeys.username);
    userImagePath = PreferencesManager().getString(StorageKeys.imagePath);

    notifyListeners();
  }

  Future<void> deleteTask(int? id) async {
    if (id == null) return;

    tasks.removeWhere((task) => task.id == id);
    calculatePercent();

    final updatedTask = tasks.map((element) => element.toJson()).toList();
    await PreferencesManager().setString(
      StorageKeys.task,
      jsonEncode(updatedTask),
    );
    notifyListeners();
  }

  Future<void> doneTask(bool? value, int? index) async {
    tasks[index!].isDone = value ?? false;

    final updatedTask = tasks.map((element) => element.toJson()).toList();
    final taskEncode = jsonEncode(updatedTask);
    await PreferencesManager().setString(StorageKeys.task, taskEncode);
    calculatePercent();
    notifyListeners();
  }

  void calculatePercent() {
    totalTasks = tasks.length;
    totalDoneTasks = tasks.where((element) => element.isDone).length;
    percent = totalDoneTasks == 0 ? 0 : totalDoneTasks / totalTasks;

    notifyListeners();
  }
}
