import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_mastering_course/core/services/preferences_manager.dart'
    show PreferencesManager;

import 'package:flutter_mastering_course/model/task_model.dart';
import 'package:flutter_mastering_course/widgets/achived_task_widget.dart';
import 'package:flutter_mastering_course/widgets/high_priority_tasks.dart';
import 'package:flutter_mastering_course/widgets/sliver_task_list_widget.dart';

import 'package:flutter_svg/flutter_svg.dart';

import 'add_task.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? username;
  List<TaskModel> tasks = [];
  bool isLoading = false;
  int totalTasks = 0;

  int totalDoneTasks = 0;

  double percent = 0;

  @override
  void initState() {
    super.initState();

    _loadTask();
    _loadUsername();
  }

  void _loadUsername() async {
    setState(() {
      username = PreferencesManager().getString('username');
    });
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
        _calculatePercent();
      });
    }
    setState(() {
      isLoading = false;
    });
  }

  _calculatePercent() {
    totalTasks = tasks.length;
    totalDoneTasks = tasks.where((element) => element.isDone).length;
    percent = totalDoneTasks == 0 ? 0 : totalDoneTasks / totalTasks;
  }

  _doneTask(bool? value, int? index) async {
    setState(() {
      tasks[index!].isDone = value ?? false;
    });

    final updatedTask = tasks.map((element) => element.toJson()).toList();
    final taskEncode = jsonEncode(updatedTask);
    await PreferencesManager().setString("task", taskEncode);
    _calculatePercent();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      // CircleAvatar(
                      //   backgroundImage: AssetImage(
                      //     'assets/images/welcome.svg',
                      //   ),
                      // ),
                      SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Good Evening , $username',
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(0xFFFFFCFC),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            'One task at a time.One step closer.',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFFC6C6C6),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 16),

                  Text(
                    'Yuhuu ,Your work Is ,',
                    style: TextStyle(color: Color(0xFFFFFCFC), fontSize: 32),
                  ),
                  Row(
                    children: [
                      Text(
                        'almost done ! ',
                        style: TextStyle(
                          color: Color(0xFFFFFCFC),
                          fontSize: 32,
                        ),
                      ),
                      SvgPicture.asset('assets/images/wave_hand.svg'),
                    ],
                  ),

                  SizedBox(height: 16),
                  ArchivedTaskWidget(
                    totalTasks: totalTasks,
                    totalDoneTasks: totalDoneTasks,
                    percent: percent,
                  ),
                  SizedBox(height: 8),
                  HighPriorityTasks(
                    tasks: tasks,
                    onTap: (bool? value, int? index) {
                      _doneTask(value, index);
                    },
                    refresh: () {
                      _loadTask();
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 24, bottom: 16),
                    child: Text(
                      'My Tasks',
                      style: TextStyle(color: Color(0xFFFFFCFC), fontSize: 20),
                    ),
                  ),
                ],
              ),
            ),
            isLoading
                ? SliverToBoxAdapter(
                    child: Center(
                      child: CircularProgressIndicator(color: Colors.white),
                    ),
                  )
                : SliverTaskListWidget(
                    tasks: tasks,
                    onTap: (bool? value, int? index) async {
                      _doneTask(value, index);
                    },
                  ),
          ],
        ),
      ),

      floatingActionButton: SizedBox(
        height: 44,
        width: 168,
        child: FloatingActionButton.extended(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          onPressed: () async {
            final bool? result = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext conte) {
                  return AddTask();
                },
              ),
            );

            if (result != null && result) {
              _loadTask();
            }
          },
          backgroundColor: Color(0xFF15B86C),
          foregroundColor: Color(0xFFFFFFCF),
          label: Text("Add New Task"),
          icon: Icon(Icons.add),
        ),
      ),
    );
  }
}
