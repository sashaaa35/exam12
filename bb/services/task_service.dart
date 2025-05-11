// services/task_service.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:your_project/models/task_model.dart';

class TaskService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Добавление новой задачи
  Future<void> addTask(TaskModel task) async {
    try {
      await _firestore.collection('tasks').add({
        'title': task.title,
        'description': task.description,
        'isCompleted': task.isCompleted,
        'createdAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Failed to add task: $e');
    }
  }

  // Получение списка задач
  Stream<List<TaskModel>> getTasks() {
    return _firestore
        .collection('tasks')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => TaskModel.fromJson(doc.data()))
            .toList());
  }

  // Обновление задачи
  Future<void> updateTask(TaskModel task) async {
    try {
      await _firestore.collection('tasks').doc(task.id).update({
        'title': task.title,
        'description': task.description,
        'isCompleted': task.isCompleted,
      });
    } catch (e) {
      throw Exception('Failed to update task: $e');
    }
  }

  // Удаление задачи
  Future<void> deleteTask(String taskId) async {
    try {
      await _firestore.collection('tasks').doc(taskId).delete();
    } catch (e) {
      throw Exception('Failed to delete task: $e');
    }
  }
}
