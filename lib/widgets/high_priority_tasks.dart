import 'package:flutter/material.dart';
import 'package:flutter_mastering_course/model/task_model.dart';

class HighPriorityTasks extends StatelessWidget {
  HighPriorityTasks({super.key, required this.tasks, required this.onTap});

  List<TaskModel> tasks = [];
  final Function(bool?, int?) onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      width: double.infinity,
      // height: double.infinity,
      decoration: BoxDecoration(
        color: Color(0xFF282828),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'High Priority Tasks',
            style: TextStyle(color: Color(0xFF15B86c), fontSize: 14),
          ),
          SizedBox(height: 8),
          ...tasks.where((e) => e.isHighPriority).take(4).map((element) {
            return Row(
              children: [
                Checkbox(
                  value: element.isDone,
                  onChanged: (bool? value) {
                    final index = tasks.indexWhere((e) {
                      return e.id == element.id;
                    });
                    onTap(value, index);
                  },
                  activeColor: Color(0xFF15B86C),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                Text(
                  element.taskName,
                  style: TextStyle(
                    color: element.isDone
                        ? Color(0xFFA0A0A0)
                        : Color(0xFFFFFCFC),
                    fontSize: 16,
                    decoration: element.isDone
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                    decorationColor: Color(0xFFA0A0A0),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            );
          }),
        ],
      ),
    );
  }
}
