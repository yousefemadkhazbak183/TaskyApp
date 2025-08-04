import 'dart:convert';
import 'package:flutter_mastering_course/core/services/preferences_manager.dart';
import 'package:flutter_mastering_course/core/widgets/task_list_widgets.dart';
import 'package:flutter_mastering_course/model/task_model.dart';

import 'package:flutter/material.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
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
        tasks = taskAfterDecode.map((e) => TaskModel.fromJson(e)).toList();
        tasks = tasks.where((element) => element.isDone == false).toList();
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
              'To Do Tasks',
              style: Theme.of(context).textTheme.bodyMedium,
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
