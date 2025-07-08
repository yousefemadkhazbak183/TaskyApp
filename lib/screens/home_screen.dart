import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_mastering_course/core/widgets/task_list_widgets.dart';
import 'package:flutter_mastering_course/model/task_model.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  @override
  void initState() {
    super.initState();

    _loadTask();
    _loadUsername();
  }

  void _loadUsername() async {
    final pref = await SharedPreferences.getInstance();

    setState(() {
      username = pref.getString('username');
    });
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
      });
      
    }
    setState(() {
        isLoading = false;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  // CircleAvatar(
                  //   backgroundImage: AssetImage(
                  //     'assets/images/welcom.svg',
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
                    style: TextStyle(color: Color(0xFFFFFCFC), fontSize: 32),
                  ),
                  SvgPicture.asset('assets/images/wave_hand.svg'),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 24, bottom: 16),
                child: Text(
                  'My Tasks',
                  style: TextStyle(color: Color(0xFFFFFCFC), fontSize: 20),
                ),
              ),
              Expanded(
                child: isLoading
                    ? Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          value: 20,
                        ),
                      )
                    : TaskListWidgets(

                        tasks: tasks,
                        onTap: (bool? value, int? index) async {
                          setState(() {
                            tasks[index!].isDone = value ?? false;
                          });
                          final pref = await SharedPreferences.getInstance();
                          final updatedTask = tasks
                              .map((element) => element.toJson())
                              .toList();
                          final taskEncode = jsonEncode(updatedTask);
                          pref.setString("task", taskEncode);

                        },

                      ),
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
