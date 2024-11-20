import 'package:flutter_application_1/pages/todo/todo_service.dart';
import 'package:flutter_application_1/util/api_servises.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dio/dio.dart';

import 'login_test.mocks.dart';

void main() {
  final MockApiService mockApiService = MockApiService();
  final TodoService todoService = TodoService(apiService: mockApiService);

  group('TodoService', () {
    test('getAllTask returns a list of tasks', () async {
      // Create a mock Dio instance
      final mockDio = MockDio();
      when(mockApiService.dio).thenReturn(mockDio);
      final mockResponse = Response(
        data: [
          {"id": 1, "title": "Task 1", "completed": false},
          {"id": 2, "title": "Task 2", "completed": true},
        ],
        statusCode: 200,
        requestOptions: RequestOptions(path: '/todos'),
      );
      when(mockDio.get('/todos')).thenAnswer((_) async => mockResponse);

      // Act
      final tasks = await todoService.getAllTask();

      // Assert
      expect(tasks, isA<List<Map<String, dynamic>>>());
      expect(tasks.length, 2);
      expect(tasks[0]['title'], 'Task 1');
    });

    test('addNewTask returns the created task', () async {
      final mockDio = MockDio();
      when(mockApiService.dio).thenReturn(mockDio);
      final newTask = {"title": "New Task", "completed": false};
      final mockResponse = Response(
        data: {"id": 1, "title": "New Task", "completed": false},
        statusCode: 201,
        requestOptions: RequestOptions(path: '/todos'),
      );
      when(mockDio.post('/todos', data: newTask))
          .thenAnswer((_) async => mockResponse);

      // Act
      final createdTask = await todoService.addNewTask(newTask);

      // Assert
      expect(createdTask, isA<Map<String, dynamic>>());
      expect(createdTask['title'], 'New Task');
      expect(createdTask['id'], 1);
    });

    test('updateTask completes without throwing', () async {
      final mockDio = MockDio();
      when(mockApiService.dio).thenReturn(mockDio);
      final updatedTask = {"title": "Updated Task", "completed": true};
      final mockResponse = Response(
        statusCode: 200,
        requestOptions: RequestOptions(path: '/todos/1'),
      );
      when(mockDio.put('/todos/1', data: updatedTask))
          .thenAnswer((_) async => mockResponse);

      // Act
      await todoService.updateTask("1", updatedTask);

      // Assert
      verify(mockDio.put('/todos/1', data: updatedTask)).called(1);
    });

    test('deleteTask returns true on success', () async {
      final mockDio = MockDio();
      when(mockApiService.dio).thenReturn(mockDio);
      final mockResponse = Response(
        data: {"isDeleted": true},
        statusCode: 200,
        requestOptions: RequestOptions(path: '/todos/1'),
      );
      when(mockDio.delete('/todos/1')).thenAnswer((_) async => mockResponse);

      // Act
      final isDeleted = await todoService.deleteTask("1");

      // Assert
      expect(isDeleted, true);
    });

    test('deleteTask returns false on failure', () async {
      final mockDio = MockDio();
      when(mockApiService.dio).thenReturn(mockDio);
      final mockResponse = Response(
        data: {"isDeleted": false},
        statusCode: 400,
        requestOptions: RequestOptions(path: '/todos/1'),
      );
      when(mockDio.delete('/todos/1')).thenAnswer((_) async => mockResponse);

      // Act
      final isDeleted = await todoService.deleteTask("1");

      // Assert
      expect(isDeleted, false);
    });
  });
}
