import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_mastering_course/core/services/preferences_manager.dart'
    show PreferencesManager;
import 'package:flutter_mastering_course/core/widgets/task_list_widgets.dart';
import 'package:flutter_mastering_course/model/task_model.dart';

class HighPriorityScreen extends StatefulWidget {
  const HighPriorityScreen({super.key});

  @override
  State<HighPriorityScreen> createState() => _HighPriorityScreenState();
}

class _HighPriorityScreenState extends State<HighPriorityScreen> {
  List<TaskModel> highPriorityTasks = [];
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
        highPriorityTasks = taskAfterDecode
            .map((e) => TaskModel.fromJson(e))
            .where((element) => element.isHighPriority)
            .toList()
            .reversed
            .toList();
      });
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('High Priority Tasks'), centerTitle: false),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: isLoading
            ? Center(child: CircularProgressIndicator(color: Colors.white))
            : TaskListWidgets(
                tasks: highPriorityTasks,
                onTap: (value, index) async {
                  setState(() {
                    highPriorityTasks[index!].isDone = value ?? false;
                  });

                  final allData = PreferencesManager().getString('task');
                  if (allData != null) {
                    List<TaskModel> allDataList = (jsonDecode(allData) as List)
                        .map((element) => TaskModel.fromJson(element))
                        .toList();
                    final int newIndex = allDataList.indexWhere(
                      (e) => e.id == highPriorityTasks[index!].id,
                    );
                    allDataList[newIndex] = highPriorityTasks[index!];
                    await PreferencesManager().setString(
                      "task",
                      jsonEncode(allDataList),
                    );
                    _loadTask();
                  }
                },
              ),
      ),
    );
  }
}
