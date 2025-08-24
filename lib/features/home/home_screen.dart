import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_mastering_course/core/constants/storage_keys.dart';
import 'package:flutter_mastering_course/core/services/preferences_manager.dart';

import 'package:flutter_mastering_course/core/widgets/custom_svg_picture.dart';

import 'package:flutter_mastering_course/model/task_model.dart';
import 'package:flutter_mastering_course/features/home/components/achived_task_widget.dart';
import 'package:flutter_mastering_course/features/home/components/high_priority_tasks.dart';
import 'package:flutter_mastering_course/features/home/components/sliver_task_list_widget.dart';

import '../add_tasks/add_task_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? username;
  String? userImagePath;
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
      username = PreferencesManager().getString(StorageKeys.username);
      userImagePath = PreferencesManager().getString(StorageKeys.imagePath);
    });
  }

  void _loadTask() async {
    setState(() {
      isLoading = true;
    });

    final finalTasks = PreferencesManager().getString(StorageKeys.task);
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

  void _calculatePercent() {
    totalTasks = tasks.length;
    totalDoneTasks = tasks.where((element) => element.isDone).length;
    percent = totalDoneTasks == 0 ? 0 : totalDoneTasks / totalTasks;
  }

  Future<void> _doneTask(bool? value, int? index) async {
    setState(() {
      tasks[index!].isDone = value ?? false;
    });

    final updatedTask = tasks.map((element) => element.toJson()).toList();
    final taskEncode = jsonEncode(updatedTask);
    await PreferencesManager().setString(StorageKeys.task, taskEncode);
    _calculatePercent();
  }

  // Make Shared Method.
  _deleteTask(int? id) async {
    if (id == null) return;
    setState(() {
      tasks.removeWhere((task) => task.id == id);
      _calculatePercent();
    });
    final updatedTask = tasks.map((element) => element.toJson()).toList();
    await PreferencesManager().setString(
      StorageKeys.task,
      jsonEncode(updatedTask),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: userImagePath == null
                              ? const AssetImage('assets/images/profile.png')
                              : FileImage(File(userImagePath!)),
                        ),
                        const SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Good Evening , $username',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            Text(
                              'One task at a time.One step closer.',
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    Text(
                      'Yuhuu ,Your work Is ,',
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                    Row(
                      children: [
                        Text(
                          'almost done ! ',
                          style: Theme.of(context).textTheme.displayLarge,
                        ),
                        CustomSvgPicture.withoutFilterColor(
                          path: 'assets/images/wave_hand.svg',
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),
                    ArchivedTaskWidget(
                      totalTasks: totalTasks,
                      totalDoneTasks: totalDoneTasks,
                      percent: percent,
                    ),
                    const SizedBox(height: 8),
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
                        style: Theme.of(
                          context,
                        ).textTheme.displaySmall!.copyWith(fontSize: 20),
                      ),
                    ),
                  ],
                ),
              ),
              isLoading
                  ? const SliverToBoxAdapter(
                      child: Center(
                        child: CircularProgressIndicator(color: Colors.white),
                      ),
                    )
                  : SliverTaskListWidget(
                      tasks: tasks,
                      onTap: (bool? value, int? index) async {
                        _doneTask(value, index);
                      },
                      onDelete: (int id) {
                        _deleteTask(id);
                      },
                      onEdit: () {
                        _loadTask();
                      },
                    ),
            ],
          ),
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
                  return const AddTaskScreen();
                },
              ),
            );

            if (result != null && result) {
              _loadTask();
            }
          },

          label: const Text("Add New Task"),
          icon: const Icon(Icons.add),
        ),
      ),
    );
  }
}
