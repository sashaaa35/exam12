// services/api_service.dart
import 'package:dio/dio.dart';
import 'package:your_project/models/task_model.dart';

class ApiService {
  final Dio _dio = Dio();
  final String _baseUrl = 'https://yourapi.com';

  // Получение списка задач
  Future<List<TaskModel>> fetchTasks() async {
    try {
      final response = await _dio.get('$_baseUrl/tasks');
      List<TaskModel> tasks = (response.data as List)
          .map((taskData) => TaskModel.fromJson(taskData))
          .toList();
      return tasks;
    } catch (e) {
      throw Exception('Failed to load tasks: $e');
    }
  }

  // Создание новой задачи
  Future<void> createTask(TaskModel task) async {
    try {
      await _dio.post('$_baseUrl/tasks', data: task.toJson());
    } catch (e) {
      throw Exception('Failed to create task: $e');
    }
  }

  // Обновление задачи
  Future<void> updateTask(TaskModel task) async {
    try {
      await _dio.put('$_baseUrl/tasks/${task.id}', data: task.toJson());
    } catch (e) {
      throw Exception('Failed to update task: $e');
    }
  }

  // Удаление задачи
  Future<void> deleteTask(String taskId) async {
    try {
      await _dio.delete('$_baseUrl/tasks/$taskId');
    } catch (e) {
      throw Exception('Failed to delete task: $e');
    }
  }
}
