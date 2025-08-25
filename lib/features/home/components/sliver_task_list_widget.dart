import 'package:flutter/material.dart';
import 'package:flutter_mastering_course/features/home/home_controller.dart';
import 'package:flutter_mastering_course/core/components/task_item_widget.dart';
import 'package:provider/provider.dart';

class SliverTaskListWidget extends StatelessWidget {
  const SliverTaskListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeController>(
      builder:
          (BuildContext context, HomeController controller, Widget? child) {
            return controller.isLoading
                ? const SliverToBoxAdapter(
                    child: Center(
                      child: CircularProgressIndicator(color: Colors.white),
                    ),
                  )
                : controller.tasks.isEmpty
                ? SliverToBoxAdapter(
                    child: Center(
                      child: Text(
                        'No Data',
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                    ),
                  )
                : SliverPadding(
                    padding: const EdgeInsets.only(bottom: 80),
                    sliver: SliverList.separated(
                      itemBuilder: (BuildContext context, int index) {
                        return TaskItemWidget(
                          model: controller.tasks[index],
                          onChanged: (bool? value) {
                            controller.doneTask(value, index);
                          },
                          onDelete: (int id) {
                            controller.deleteTask(id);
                          },
                          onEdit: () => controller.loadTask(),
                        );
                      },
                      itemCount: controller.tasks.length,
                      separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox(height: 8);
                      },
                    ),
                  );
          },
    );
  }
}
