import 'package:flutter_application_1/pages/todo/todo_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:dio/dio.dart';
import 'package:flutter_application_1/util/api_servises.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'todo_test.mocks.dart';

@GenerateMocks([Dio])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late MockDio mockDio;
  late ApiService apiService;
  late TodoService todoService;

  setUp(() {
    mockDio = MockDio();
    todoService = TodoService();
    SharedPreferences.setMockInitialValues({});
  });

  group('TodoService Tests', () {
    test('getAllTask should return a list of tasks', () async {
      // Mock response
      final mockResponse = Response(
        requestOptions: RequestOptions(path: '/todos'),
        data: {
          "todos": [
            {"id": 1, "title": "Task 1", "completed": false},
            {"id": 2, "title": "Task 2", "completed": true},
          ]
        },
        statusCode: 200,
      );

      // Setup mock behavior
      when(mockDio.get('/todos', options: anyNamed('options')))
          .thenAnswer((_) async => mockResponse);

      // Call the method
      final result = await todoService.getAllTask();

      // Assertions
      expect(result.length, 2);
      expect(result[0]['title'], 'Task 1');
      expect(result[1]['completed'], true);
      verify(mockDio.get('/todos')).called(1);
    });

    test('addNewTask should return the created task', () async {
      final task = {"title": "New Task", "completed": false};
      final mockResponse = Response(
        requestOptions: RequestOptions(path: '/todos/add'),
        data: {"id": 3, "title": "New Task", "completed": false},
        statusCode: 201,
      );

      when(mockDio.post('/todos/add', options: anyNamed('options'), data: task))
          .thenAnswer((_) async => mockResponse);

      final result = await todoService.addNewTask(task);

      expect(result['title'], 'New Task');
      expect(result['id'], 3);
      verify(mockDio.post('/todos/add', data: task)).called(1);
    });

    test('updateTask should call Dio.put with correct parameters', () async {
      final id = 1;
      final payload = {"title": "Updated Task", "completed": true};
      final mockResponse = Response(
        requestOptions: RequestOptions(path: '/todos/$id'),
        statusCode: 200,
      );

      when(mockDio.put('/todos/$id',
              options: anyNamed('options'), data: payload))
          .thenAnswer((_) async => mockResponse);

      await todoService.updateTask(id, payload);

      verify(mockDio.put('/todos/$id', data: payload)).called(1);
    });

    test('deleteTask should return true when task is deleted', () async {
      final id = 1;
      final mockResponse = Response(
        requestOptions: RequestOptions(path: '/todos/$id'),
        data: {"isDeleted": true},
        statusCode: 200,
      );

      when(mockDio.delete('/todos/$id', options: anyNamed('options')))
          .thenAnswer((_) async => mockResponse);

      final result = await todoService.deleteTask(id);

      expect(result, true);
      verify(mockDio.delete('/todos/$id')).called(1);
    });
  });
}
