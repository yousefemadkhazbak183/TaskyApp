import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_mastering_course/core/theme/theme_controller.dart';
import 'package:flutter_mastering_course/features/home/home_controller.dart';
import 'package:provider/provider.dart';

class ArchivedTaskWidget extends StatelessWidget {
  const ArchivedTaskWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeController>(
      builder: (BuildContext context, HomeController controller, Widget? child) {
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: ThemeController.isDark()
                  ? Colors.transparent
                  : const Color(0xFFD1DAD6),
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
                  const SizedBox(height: 4),
                  Text(
                    '${controller.totalDoneTasks} Out of ${controller.totalTasks} Done',
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
                        value: controller.percent,
                        backgroundColor: Theme.of(context).colorScheme.surface,
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          Color(0xFF15B86C),
                        ),
                        strokeWidth: 5,
                      ),
                    ),
                  ),
                  Text(
                    "${((controller.percent * 100).toInt())}%",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
