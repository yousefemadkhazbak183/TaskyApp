import 'package:flutter_mastering_course/core/constants/hive_constant.dart';
import 'package:flutter_mastering_course/model/task_model.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';

class HiveStorageManager {
  static final HiveStorageManager _instance = HiveStorageManager._();

  HiveStorageManager._();

  factory HiveStorageManager() {
    return _instance;
  }
  late Box<TaskModel> _taskBox;

  Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(TaskModelAdapter());
    _taskBox = await Hive.openBox<TaskModel>(HiveConstant.taskBoxName);
  }

  Future<void> saveTasks(List<TaskModel> list) async {
    await _taskBox.clear();
    _taskBox.addAll(list);
  }

  List<TaskModel> loadTask() {
    return _taskBox.values.toList();
  }

  Future<void> clearTasks() async {
    await _taskBox.clear();
  }
}
