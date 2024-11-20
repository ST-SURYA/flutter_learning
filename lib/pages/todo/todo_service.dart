import 'package:flutter_application_1/util/api_servises.dart';
import 'package:get/get.dart';

class TodoService {
  final ApiService apiService;

  TodoService({ApiService? apiService})
      : apiService = apiService ?? ApiService();

  Future<List<Map<String, dynamic>>> getAllTask() async {
    final response = await apiService.dio.get('/todos');
    // Assuming the response data is a list of tasks
    return List<Map<String, dynamic>>.from(response.data);
  }

  Future<Map<String, dynamic>> addNewTask(Map<String, dynamic> task) async {
    try {
      final response = await apiService.dio.post('/todos', data: task);
      return response.data;
    } catch (e) {
      print(e);
      return {};
    }
  }

  Future<void> updateTask(String id, Map<String, dynamic> payload) async {
    final response = await apiService.dio.put('/todos/$id', data: payload);
  }

  Future<bool> deleteTask(String id) async {
    try {
      final response = await apiService.dio.delete('/todos/$id');
      if (response.statusCode == 200) {
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }
}
