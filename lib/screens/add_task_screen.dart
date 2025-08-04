import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_mastering_course/core/services/preferences_manager.dart';
import 'package:flutter_mastering_course/core/widgets/custom_text_form_field.dart';
import 'package:flutter_mastering_course/model/task_model.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTaskScreen> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  /// ToDO: Dispose this controllers
  final TextEditingController addTaskController = TextEditingController();

  final TextEditingController addTaskDescriptionController =
      TextEditingController();

  bool isHighPriority = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('New Task', style: Theme.of(context).textTheme.bodyMedium),
        iconTheme: Theme.of(context).iconTheme,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Form(
            key: _key,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: 8),
                        CustomTextFormField(
                          title: 'Task Name',
                          controller: addTaskController,
                          hintText: 'Finish UI design for login screen',
                          validator: (String? value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please enter task name';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20),
                        CustomTextFormField(
                          title: 'Task Description',
                          controller: addTaskDescriptionController,
                          hintText:
                              'Finish onboarding UI and hand off to \n devs by Thursday.',
                          maxLines: 5,
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'High Priority',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            Switch(
                              value: isHighPriority,

                              onChanged: (value) {
                                setState(() {
                                  isHighPriority = value;
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(MediaQuery.of(context).size.width, 40),
                  ),
                  onPressed: () async {
                    if (_key.currentState?.validate() ?? false) {
                      final taskJson = PreferencesManager().getString('task');

                      List<dynamic> listTask = [];
                      if (taskJson != null) {
                        listTask = jsonDecode(taskJson);
                      }
                      TaskModel model = TaskModel(
                        id: listTask.length + 1,
                        taskName: addTaskController.text,
                        taskDescription: addTaskDescriptionController.text,
                        isHighPriority: isHighPriority,
                      );

                      listTask.add(model.toJson());

                      final taskEncode = jsonEncode(listTask);
                      await PreferencesManager().setString("task", taskEncode);
                      Navigator.of(context).pop(true);
                    }
                  },
                  label: Text('Add Task'),
                  icon: Icon(Icons.add),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
