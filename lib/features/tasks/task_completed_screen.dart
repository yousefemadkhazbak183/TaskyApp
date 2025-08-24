import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_mastering_course/core/constants/storage_keys.dart';
import 'package:flutter_mastering_course/core/services/preferences_manager.dart';

import '../../core/components/task_list_widgets.dart';
import '../../model/task_model.dart' show TaskModel;

class TaskCompletedScreen extends StatefulWidget {
  const TaskCompletedScreen({super.key});

  @override
  State<TaskCompletedScreen> createState() => _TaskCompletedScreenState();
}

class _TaskCompletedScreenState extends State<TaskCompletedScreen> {
  List<TaskModel> completeTasks = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    _loadTask();
  }

  void _loadTask() async {
    setState(() {
      isLoading = true;
    });

    final finalTasks = PreferencesManager().getString(StorageKeys.task);
    if (finalTasks != null) {
      final taskAfterDecode = jsonDecode(finalTasks) as List<dynamic>;

      setState(() {
        completeTasks = taskAfterDecode
            .map((e) => TaskModel.fromJson(e))
            .where((element) => element.isDone)
            .toList();
      });
    }
    setState(() {
      isLoading = false;
    });
  }

  _deleteTask(int? id) async {
    List<TaskModel> deleteTask = [];
    if (id == null) return;
    final finalTasks = PreferencesManager().getString(StorageKeys.task);
    if (finalTasks != null) {
      final taskAfterDecode = jsonDecode(finalTasks) as List<dynamic>;
      deleteTask = taskAfterDecode.map((e) => TaskModel.fromJson(e)).toList();
      deleteTask.removeWhere((e) => e.id == id);

      setState(() {
        completeTasks.removeWhere((task) => task.id == id);
      });
      final updatedTask = deleteTask
          .map((element) => element.toJson())
          .toList();
      await PreferencesManager().setString(
        StorageKeys.task,
        jsonEncode(updatedTask),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Text(
              'Completed Tasks',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: isLoading
                  ? const Center(
                      child: CircularProgressIndicator(color: Colors.white),
                    )
                  : TaskListWidgets(
                      tasks: completeTasks,
                      onTap: (value, index) async {
                        setState(() {
                          completeTasks[index!].isDone = value ?? false;
                        });

                        final allData = PreferencesManager().getString(
                          StorageKeys.task,
                        );
                        if (allData != null) {
                          final List<TaskModel> allDataList =
                              (jsonDecode(allData) as List)
                                  .map((element) => TaskModel.fromJson(element))
                                  .toList();
                          final int newIndex = allDataList.indexWhere(
                            (e) => e.id == completeTasks[index!].id,
                          );
                          allDataList[newIndex] = completeTasks[index!];
                          await PreferencesManager().setString(
                            StorageKeys.task,
                            jsonEncode(allDataList),
                          );
                          _loadTask();
                        }
                      },
                      onDelete: (int id) {
                        _deleteTask(id);
                      },
                      onEdit: () {
                        _loadTask();
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
