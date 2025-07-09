import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_mastering_course/model/task_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
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
        title: Text('New Task'),
        iconTheme: IconThemeData(color: Color(0xFFFFFCFC)),
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Task Name',
                          style: TextStyle(
                            color: Color(0xFFFFFCFC),
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 8),
                        TextFormField(
                          controller: addTaskController,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: 'Finish UI design for login screen',
                            hintStyle: TextStyle(color: Color(0xFF6D6D6D)),
                            filled: true,
                            fillColor: Color(0xFF282828),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          validator: (String? value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please enter task name';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20),
                        SizedBox(height: 8),
                        TextFormField(
                          controller: addTaskDescriptionController,
                          style: TextStyle(color: Colors.white),
                          maxLines: 5,
                          decoration: InputDecoration(
                            hintText:
                                'Finish onboarding UI and hand off to \n devs by Thursday.',
                            hintStyle: TextStyle(color: Color(0xFF6D6D6D)),
                            filled: true,
                            fillColor: Color(0xFF282828),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'High Priority',
                              style: TextStyle(
                                color: Color(0xFFFFFCFC),
                                fontSize: 16,
                              ),
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
                    backgroundColor: Color(0xFF15B86C),
                    foregroundColor: Color(0xFFFFFCFC),
                    fixedSize: Size(MediaQuery.of(context).size.width, 40),
                  ),
                  onPressed: () async {
                    if (_key.currentState?.validate() ?? false) {
                      final pref = await SharedPreferences.getInstance();
                      final taskJson = pref.getString('task');

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
                      await pref.setString("task", taskEncode);
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
