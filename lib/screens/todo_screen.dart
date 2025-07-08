import 'dart:convert';
import 'package:flutter_mastering_course/core/widgets/task_list_widgets.dart';
import 'package:flutter_mastering_course/model/task_model.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

    final pref = await SharedPreferences.getInstance();
    final finalTasks = pref.getString('task');
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
    return Scaffold(
      appBar: AppBar(title: Text('To Do Tasks')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: isLoading
            ? Center(child: CircularProgressIndicator(color: Colors.white))
            : TaskListWidgets(
                tasks: tasks,
                onTap: (value, index) async {
                  setState(() {
                    tasks[index!].isDone = value ?? false;
                  });
                  final pref = await SharedPreferences.getInstance();
                  
                  final allData = pref.getString('task');
                  if (allData != null) {
                    List<TaskModel> allDataList = (jsonDecode(allData) as List)
                        .map((element) => TaskModel.fromJson(element))
                        .toList();
                    final int newIndex = allDataList.indexWhere(
                      (e) => e.id == tasks[index!].id,
                    );
                    allDataList[newIndex] = tasks[index!];
                    pref.setString("task", jsonEncode(allDataList));
                    _loadTask();
                  }
                },
              ),
      ),
    );
  }
}
