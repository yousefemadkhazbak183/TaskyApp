import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_mastering_course/core/theme/theme_controller.dart';

class ArchivedTaskWidget extends StatelessWidget {
  ArchivedTaskWidget({
    super.key,
    required this.totalTasks,
    required this.totalDoneTasks,
    required this.percent,
  });

  int totalTasks = 0;

  int totalDoneTasks = 0;

  double percent = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Achieved Tasks',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              SizedBox(height: 4),
              Text(
                "$totalDoneTasks Out of $totalTasks",
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ],
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              Transform.rotate(
                angle: -pi / 2,
                child: SizedBox(
                  height: 48,
                  width: 48,
                  child: CircularProgressIndicator(
                    value: percent,
                    backgroundColor: Theme.of(context).colorScheme.surface,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Color(0xFF15B86C),
                    ),
                    strokeWidth: 5,
                  ),
                ),
              ),
              Text(
                "${((percent * 100).toInt())}%",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
