import 'package:flutter/material.dart';

import 'package:flutter_mastering_course/core/widgets/custom_text_form_field.dart';
import 'package:flutter_mastering_course/features/add_tasks/add_task_controller.dart';

import 'package:provider/provider.dart';

class AddTaskScreen extends StatelessWidget {
  const AddTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AddTaskController>(
      create: (_) => AddTaskController(),
      builder: (context, _) {
        final controller = context.read<AddTaskController>();
        return Scaffold(
          appBar: AppBar(
            centerTitle: false,
            title: Text(
              'New Task',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            iconTheme: Theme.of(context).iconTheme,
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Form(
                key: controller.key,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            const SizedBox(height: 8),
                            CustomTextFormField(
                              title: 'Task Name',
                              controller: controller.addTaskController,
                              hintText: 'Finish UI design for login screen',
                              validator: (String? value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Please enter task name';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),
                            CustomTextFormField(
                              title: 'Task Description',
                              controller:
                                  controller.addTaskDescriptionController,
                              hintText:
                                  'Finish onboarding UI and hand off to \n devs by Thursday.',
                              maxLines: 5,
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'High Priority',
                                  style: Theme.of(
                                    context,
                                  ).textTheme.titleMedium,
                                ),
                                Consumer<AddTaskController>(
                                  builder:
                                      (
                                        BuildContext context,
                                        AddTaskController value,
                                        Widget? child,
                                      ) {
                                        return Switch(
                                          value: value.isHighPriority,

                                          onChanged: (value) {
                                            controller.toggle(value);
                                          },
                                        );
                                      },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(MediaQuery.of(context).size.width, 40),
                      ),
                      onPressed: () async {
                        context.read<AddTaskController>().addTask(context);
                      },
                      label: const Text('Add Task'),
                      icon: const Icon(Icons.add),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
