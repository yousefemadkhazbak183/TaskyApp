import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_mastering_course/model/task_model.dart';
import 'package:flutter_mastering_course/widget/add_task.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? username;
  List<TaskModel> task = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    _loadUsername();
    _loadTask();
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
    await Future.delayed(Duration(seconds: 2));
    final pref = await SharedPreferences.getInstance();
    final finalTasks = pref.getString('task');
    if (finalTasks != null) {
      final taskAfterDecode = jsonDecode(finalTasks) as List<dynamic>;

      setState(() {
        task = taskAfterDecode.map((e) => TaskModel.fromJson(e)).toList();
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: SizedBox(
        height: 44,
        width: 168,
        child: FloatingActionButton.extended(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          onPressed: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext conte) {
                  return AddTask();
                },
              ),
            );
            _loadTask();
          },
          backgroundColor: Color(0xFF15B86C),
          foregroundColor: Color(0xFFFFFFCF),
          label: Text("Add New Task"),
          icon: Icon(Icons.add),
        ),
      ),
      backgroundColor: Color(0xFF181818),
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
                        child: CircularProgressIndicator(color: Colors.white),
                      )
                    : ListView.builder(
                        padding: EdgeInsets.only(bottom: 40),
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Container(
                              alignment: Alignment.center,
                              height: 56,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Color(0xFF282828),
                              ),
                              child: Row(
                                children: [
                                  SizedBox(width: 8),
                                  Checkbox(
                                    value: task[index].isDone,
                                    onChanged: (bool? value) async {
                                      setState(() {
                                        task[index].isDone = value ?? false;
                                      });
                                      final pref =
                                          await SharedPreferences.getInstance();
                                      final updatedTask = task
                                          .map((element) => element.toJson())
                                          .toList();
                                      final taskEncode = jsonEncode(
                                        updatedTask,
                                      );
                                      pref.setString("task", taskEncode);
                                    },
                                    activeColor: Color(0xFF15B86C),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                  ),
                                  SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          task[index].taskName,
                                          style: TextStyle(
                                            color: task[index].isDone
                                                ? Color(0xFFA0A0A0)
                                                : Color(0xFFFFFCFC),
                                            fontSize: 16,
                                            decoration: task[index].isDone
                                                ? TextDecoration.lineThrough
                                                : TextDecoration.none,
                                            decorationColor: Color(0xFFA0A0A0),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          maxLines: 1,
                                        ),
                                        Text(
                                          task[index].taskDescription,
                                          style: TextStyle(
                                            color: Color(0xFC6C6C6F),
                                            fontSize: 14,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.more_vert,
                                      color: task[index].isDone
                                          ? Color(0xFFA0A0A0)
                                          : Color(0xFFC6C6C6),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        itemCount: task.length,
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
