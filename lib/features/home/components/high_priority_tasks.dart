import 'package:flutter/material.dart';
import 'package:flutter_mastering_course/core/theme/theme_controller.dart';
import 'package:flutter_mastering_course/core/widgets/custom_check_box.dart';
import 'package:flutter_mastering_course/features/home/home_controller.dart';
import 'package:flutter_mastering_course/features/tasks/high_priority_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class HighPriorityTasks extends StatelessWidget {
  const HighPriorityTasks({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeController>(
      builder:
          (BuildContext context, HomeController controller, Widget? child) {
            return Container(
              padding: const EdgeInsets.all(16),
              width: double.infinity,

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
                        const SizedBox(height: 8),
                        ...controller.tasks.reversed
                            .where((e) => e.isHighPriority)
                            .take(4)
                            .map((element) {
                              return Row(
                                children: [
                                  CustomCheckBox(
                                    value: element.isDone,
                                    onChanged: (bool? value) {
                                      final index = controller.tasks.indexWhere(
                                        (e) {
                                          return e.id == element.id;
                                        },
                                      );
                                      controller.doneTask(value, index);
                                    },
                                  ),

                                  Expanded(
                                    child: Text(
                                      element.taskName,
                                      style: element.isDone
                                          ? Theme.of(
                                              context,
                                            ).textTheme.titleLarge
                                          : Theme.of(
                                              context,
                                            ).textTheme.titleMedium,
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
                            return const HighPriorityScreen();
                          },
                        ),
                      );
                      controller.loadTask();
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
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
                              ? const Color(0xFFC6C6C6)
                              : const Color(0xFF3A4640),
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
    );
  }
}
