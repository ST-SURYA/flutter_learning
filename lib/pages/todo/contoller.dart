import 'package:flutter_application_1/pages/dashbard/controller.dart';
import 'package:flutter_application_1/widget/common/snackbar.dart';
import 'package:get/get.dart';
import 'package:flutter_application_1/pages/todo/todo_service.dart';

class TaskController extends GetxController {
  var tasks = <Map<String, dynamic>>[].obs;
  final TodoService todoService = TodoService();
  final DashboardController dashboardController =
      Get.put(DashboardController());
  @override
  void onInit() async {
    super.onInit();
    await fetchTask();
  }

  Future<void> fetchTask() async {
    try {
      tasks.value = await todoService.getAllTask();
    } catch (e) {
      print("Error fetching tasks: $e");
    }
  }

  // Toggle task status
  void toggleTaskStatus(int id) async {
    final task = tasks.firstWhere((item) => item['id'] == id);

    if (task != null) {
      task['completed'] = !(task['completed'] ?? false);
      await todoService
          .updateTask(id, {"completed": !(task['completed'] ?? false)});
      Snackbar.showSnackbar(
        title: 'TODO',
        message: 'Status Updated',
      );
      tasks.refresh();
    }
  }

  void toggleEditing(int id, bool isEditing) {
    final task = tasks.firstWhere((item) => item['id'] == id);
    if (task != null) {
      task['isEditing'] = isEditing;
      tasks.refresh();
    }
  }

  void updateTask(int id, String newTitle) async {
    final task = tasks.firstWhere((item) => item['id'] == id);
    if (task != null) {
      task['todo'] = newTitle;
      await todoService.updateTask(id, {"todo": newTitle});
      task['isEditing'] = false;
      Snackbar.showSnackbar(
        title: 'TODO',
        message: 'Title Updated ',
      );
      tasks.refresh();
    }
  }

  // Add task
  void addTask(String title) async {
    var newTask = {
      "todo": title,
      "completed": false,
      "userId": dashboardController.userData.value?["id"],
    };
    await todoService.addNewTask(newTask);
    Snackbar.showSnackbar(
      title: 'TODO',
      message: 'New task added',
    );
    tasks.add(newTask);
  }

  // Remove task
  void removeTask(int id) async {
    final isDeleted = await todoService.deleteTask(id);
    Snackbar.showSnackbar(
      title: 'TODO',
      message: 'Task Deleted',
    );
    tasks.removeWhere((item) => item['id'] == id);
  }
}
