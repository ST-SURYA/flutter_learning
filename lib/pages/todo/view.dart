import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/todo/contoller.dart';
import 'package:get/get.dart';

class TodoPage extends StatelessWidget {
  final taskController = Get.put(TaskController());
  final TextEditingController taskControllerInput = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('To-Do List')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: taskControllerInput,
              decoration: const InputDecoration(labelText: 'Add new task'),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (taskControllerInput.text.isNotEmpty) {
                taskController.addTask(taskControllerInput.text);
                taskControllerInput.clear();
              }
            },
            child: const Text('Add Task'),
          ),
          Expanded(
            child: Obx(
              () => ListView.builder(
                itemCount: taskController.tasks.length,
                itemBuilder: (context, index) {
                  final task = taskController.tasks[index];
                  final editController =
                      TextEditingController(text: task["todo"]);
                  return ListTile(
                    title: task['isEditing'] == true
                        ? TextField(
                            controller: editController,
                            autofocus: true,
                            onSubmitted: (newText) {
                              taskController.updateTask(task["id"], newText);
                              taskController.toggleEditing(task["id"], false);
                            },
                          )
                        : GestureDetector(
                            onTap: () {
                              taskController.toggleEditing(task["id"], true);
                            },
                            child: Text(task["todo"]),
                          ),
                    leading: Checkbox(
                      value: task["completed"],
                      onChanged: (value) {
                        taskController.toggleTaskStatus(task["id"]);
                      },
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => taskController.removeTask(task["id"]),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
