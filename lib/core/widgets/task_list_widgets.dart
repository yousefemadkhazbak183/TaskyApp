
import 'package:flutter/material.dart';
import 'package:flutter_mastering_course/model/task_model.dart';

class TaskListWidgets extends StatelessWidget {
  const TaskListWidgets({
    super.key,
    required this.tasks,
    required this.onTap,
     this.emptyMessage,
  });

  final List<TaskModel> tasks;
  final Function(bool?, int?) onTap;
  final String? emptyMessage;

  @override
  Widget build(BuildContext context) {
    return tasks.isEmpty
        ? Center(
            child: Text(
              emptyMessage ?? 'not Data',
              style: TextStyle(fontSize: 24, color: Colors.white),
            ),
          )
        : ListView.separated(
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
                        value: tasks[index].isDone,
                        onChanged: (bool? value) {
                          onTap(value, index);
                        },
                        activeColor: Color(0xFF15B86C),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              tasks[index].taskName,
                              style: TextStyle(
                                color: tasks[index].isDone
                                    ? Color(0xFFA0A0A0)
                                    : Color(0xFFFFFCFC),
                                fontSize: 16,
                                decoration: tasks[index].isDone
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
                                decorationColor: Color(0xFFA0A0A0),
                                overflow: TextOverflow.ellipsis,
                              ),
                              maxLines: 1,
                            ),
                            Text(
                              tasks[index].taskDescription,
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
                          color: tasks[index].isDone
                              ? Color(0xFFA0A0A0)
                              : Color(0xFFC6C6C6),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            itemCount: tasks.length,
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(height: 8);
            },
          );
  }
}
