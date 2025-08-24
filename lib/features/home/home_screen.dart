import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flutter_mastering_course/core/widgets/custom_svg_picture.dart';
import 'package:flutter_mastering_course/features/home/home_controller.dart';

import 'package:flutter_mastering_course/features/home/components/achived_task_widget.dart';
import 'package:flutter_mastering_course/features/home/components/high_priority_tasks.dart';
import 'package:flutter_mastering_course/features/home/components/sliver_task_list_widget.dart';
import 'package:provider/provider.dart';

import '../add_tasks/add_task_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeController>(
      create: (context) => HomeController(),

      child: Consumer<HomeController>(
        builder: (BuildContext context, HomeController value, Widget? child) {
          final HomeController controller = context.read<HomeController>()
            ..init();
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
                                backgroundImage: value.userImagePath == null
                                    ? const AssetImage(
                                        'assets/images/profile.png',
                                      )
                                    : FileImage(File(value.userImagePath!)),
                              ),
                              const SizedBox(width: 8),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Good Evening , ${value.username}',
                                    style: Theme.of(
                                      context,
                                    ).textTheme.titleMedium,
                                  ),
                                  Text(
                                    'One task at a time.One step closer.',
                                    style: Theme.of(
                                      context,
                                    ).textTheme.titleSmall,
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
                            totalTasks: value.totalTasks,
                            totalDoneTasks: value.totalDoneTasks,
                            percent: value.percent,
                          ),
                          const SizedBox(height: 8),
                          HighPriorityTasks(
                            tasks: value.tasks,
                            onTap: (bool? value, int? index) {
                              controller.doneTask(value, index);
                            },
                            refresh: () {
                              controller.loadTask();
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
                    value.isLoading
                        ? const SliverToBoxAdapter(
                            child: Center(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            ),
                          )
                        : SliverTaskListWidget(
                            tasks: value.tasks,
                            onTap: (bool? value, int? index) async {
                              controller.doneTask(value, index);
                            },
                            onDelete: (int id) {
                              controller.deleteTask(id);
                            },
                            onEdit: () {
                              controller.loadTask();
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
                    controller.loadTask();
                  }
                },

                label: const Text("Add New Task"),
                icon: const Icon(Icons.add),
              ),
            ),
          );
        },
      ),
    );
  }
}
