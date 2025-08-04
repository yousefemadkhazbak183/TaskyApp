import 'package:flutter/material.dart';
import 'package:flutter_mastering_course/core/theme/theme_controller.dart';
import 'package:flutter_mastering_course/core/widgets/custom_check_box.dart';
import 'package:flutter_mastering_course/model/task_model.dart';

class TaskItemWidget extends StatelessWidget {
  TaskItemWidget({super.key, required this.model, required this.onChanged});
  TaskModel model;
  final Function(bool?) onChanged;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 56,
      width: double.infinity,

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Theme.of(context).colorScheme.primaryContainer,
        border: Border.all(
          color: ThemeController.isDark()
              ? Colors.transparent
              : Color(0xFFD1DAD6),
        ),
      ),
      child: Row(
        children: [
          SizedBox(width: 8),
          CustomCheckBox(
            value: model.isDone,
            onChanged: (bool? value) => onChanged(value),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.taskName,
                  style: TextStyle(
                    color: model.isDone
                        ? Theme.of(context).colorScheme.secondary
                        : Theme.of(context).colorScheme.primary,
                    fontSize: 16,
                    decoration: model.isDone
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                    decorationColor: Color(0xFFA0A0A0),
                    overflow: TextOverflow.ellipsis,
                  ),
                  maxLines: 1,
                ),
                Text(
                  model.taskDescription,
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
              color: model.isDone ? Color(0xFF6A6A6A) : Color(0xFF3A4640),
            ),
          ),
        ],
      ),
    );
  }
}
