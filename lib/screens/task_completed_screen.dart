import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_mastering_course/core/services/preferences_manager.dart';

import '../core/widgets/task_list_widgets.dart';
import '../model/task_model.dart' show TaskModel;

class TaskCompletedScreen extends StatefulWidget {
  const TaskCompletedScreen({super.key});

  @override
  State<TaskCompletedScreen> createState() => _TaskCompletedScreenState();
}

class _TaskCompletedScreenState extends State<TaskCompletedScreen> {
  List<TaskModel> tasks = [];
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

    final finalTasks = PreferencesManager().getString('task');
    if (finalTasks != null) {
      final taskAfterDecode = jsonDecode(finalTasks) as List<dynamic>;

      setState(() {
        tasks = taskAfterDecode
            .map((e) => TaskModel.fromJson(e))
            .where((element) => element.isDone)
            .toList();
      });
    }
    setState(() {
      isLoading = false;
    });
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
              style: TextStyle(fontSize: 20, color: Color(0xFFFFFCFC)),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: isLoading
                  ? Center(
                      child: CircularProgressIndicator(color: Colors.white),
                    )
                  : TaskListWidgets(
                      tasks: tasks,
                      onTap: (value, index) async {
                        setState(() {
                          tasks[index!].isDone = value ?? false;
                        });

                        final allData = PreferencesManager().getString('task');
                        if (allData != null) {
                          List<TaskModel> allDataList =
                              (jsonDecode(allData) as List)
                                  .map((element) => TaskModel.fromJson(element))
                                  .toList();
                          final int newIndex = allDataList.indexWhere(
                            (e) => e.id == tasks[index!].id,
                          );
                          allDataList[newIndex] = tasks[index!];
                          await PreferencesManager().setString(
                            "task",
                            jsonEncode(allDataList),
                          );
                          _loadTask();
                        }
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
