import 'package:flutter/material.dart';
import 'package:flutter_mastering_course/model/task_model.dart';
import 'package:flutter_mastering_course/screens/high_priority_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HighPriorityTasks extends StatelessWidget {
  HighPriorityTasks({
    super.key,
    required this.tasks,
    required this.onTap,
    required this.refresh,
  });

  List<TaskModel> tasks = [];
  final Function(bool?, int?) onTap;
  final Function refresh;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      width: double.infinity,

      decoration: BoxDecoration(
        color: Color(0xFF282828),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'High Priority Tasks',
                  style: TextStyle(color: Color(0xFF15B86c), fontSize: 14),
                ),
                SizedBox(height: 8),
                ...tasks.reversed.where((e) => e.isHighPriority).take(4).map((
                  element,
                ) {
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
                      Expanded(
                        child: Text(
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
                      ),
                    ],
                  );
                }),
              ],
            ),
          ),
          GestureDetector(
            onTap: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return HighPriorityScreen();
                  },
                ),
              );
              refresh();
            },
            child: Container(
              padding: EdgeInsets.all(8),
              height: 48,
              width: 48,
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xFF6E6E6E)),
                shape: BoxShape.circle,
                // borderRadius: BorderRadius.circular(100),
                color: Color(0xFF282828),
              ),
              child: SvgPicture.asset('assets/images/arrow_up_right.svg'),
            ),
          ),
        ],
      ),
    );
  }
}
