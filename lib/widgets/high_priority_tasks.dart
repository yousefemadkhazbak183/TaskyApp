import 'package:flutter/material.dart';
import 'package:flutter_mastering_course/core/theme/theme_controller.dart';
import 'package:flutter_mastering_course/core/widgets/custom_check_box.dart';
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
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: ThemeController.isDark()
              ? Colors.transparent
              : Color(0xFFD1DAD6),
        ),
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
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                SizedBox(height: 8),
                ...tasks.reversed.where((e) => e.isHighPriority).take(4).map((
                  element,
                ) {
                  return Row(
                    children: [
                      CustomCheckBox(
                        value: element.isDone,
                        onChanged: (bool? value) {
                          final index = tasks.indexWhere((e) {
                            return e.id == element.id;
                          });
                          onTap(value, index);
                        },
                      ),

                      Expanded(
                        child: Text(
                          element.taskName,
                          style: element.isDone
                              ? Theme.of(context).textTheme.titleLarge
                              : Theme.of(context).textTheme.titleMedium,
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
                border: Border.all(
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
                shape: BoxShape.circle,
                color: Theme.of(context).colorScheme.primaryContainer,
              ),
              child: SvgPicture.asset(
                'assets/images/arrow_up_right.svg',
                colorFilter: ColorFilter.mode(
                  ThemeController.isDark()
                      ? Color(0xFFC6C6C6)
                      : Color(0xFF3A4640),
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
