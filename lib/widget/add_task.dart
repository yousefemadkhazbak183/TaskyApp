import 'package:flutter/material.dart';

class AddTask extends StatefulWidget {
  AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  /// ToDO: Dispose this controllers
  final TextEditingController addTaskController =
      TextEditingController();

  final TextEditingController addTaskDescriptionController =
      TextEditingController();

  bool isHighPriority = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF181818),
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Color(0xFF181818),
        iconTheme: IconThemeData(color: Color(0xFFFFFCFC)),
        title: Text('New Task'),
        titleTextStyle: TextStyle(
          color: Color(0xFFFFFCFC),
          fontSize: 20,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          child: Form(
            key: _key,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Task Name',
                          style: TextStyle(
                            color: Color(0xFFFFFCFC),
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 8),
                        TextFormField(
                          controller: addTaskController,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText:
                                'Finish UI design for login screen',
                            hintStyle: TextStyle(
                              color: Color(0xFF6D6D6D),
                            ),
                            filled: true,
                            fillColor: Color(0xFF282828),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          validator: (String? value) {
                            if (value == null ||
                                value.trim().isEmpty) {
                              return 'Please enter task name';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Task Description',
                          style: TextStyle(
                            color: Color(0xFFFFFCFC),
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 8),
                        TextFormField(
                          controller: addTaskDescriptionController,
                          style: TextStyle(color: Colors.white),
                          maxLines: 5,
                          decoration: InputDecoration(
                            hintText:
                                'Finish onboarding UI and hand off to \n devs by Thursday.',
                            hintStyle: TextStyle(
                              color: Color(0xFF6D6D6D),
                            ),
                            filled: true,
                            fillColor: Color(0xFF282828),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          validator: (String? value) {
                            if (value == null ||
                                value.trim().isEmpty) {
                              return 'Please enter task description';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'High Priority',
                              style: TextStyle(
                                color: Color(0xFFFFFCFC),
                                fontSize: 16,
                              ),
                            ),
                            Switch(
                              value: isHighPriority,
                              activeTrackColor: Color(0xFF15B86C),
                              onChanged: (value) {
                                setState(() {
                                  isHighPriority = value;
                                });
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
                    backgroundColor: Color(0xFF15B86C),
                    foregroundColor: Color(0xFFFFFCFC),
                    fixedSize: Size(
                      MediaQuery.of(context).size.width,
                      40,
                    ),
                  ),
                  onPressed: () {
                    if (_key.currentState?.validate() ?? false) {}
                  },
                  label: Text('Add Task'),
                  icon: Icon(Icons.add),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
