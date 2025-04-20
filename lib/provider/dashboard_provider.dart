import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:personal_task_manager/utils/table_name.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../model/task_model.dart';

class DashboardProvider with ChangeNotifier {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  final SupabaseClient _client = Supabase.instance.client;
  List<TaskModel> _tasks = [];

  List<TaskModel> get tasks => _tasks;

  void setLoadingToggle(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  /// Fetch tasks of logged-in user from Supabase
  Future<void> fetchTasks() async {
    final userId = _client.auth.currentUser?.id;
    if (userId == null) return;

    setLoadingToggle(true);

    final response =
        await _client.from(TableName.taskTable).select().eq('user_id', userId);

    _tasks =
        List<TaskModel>.from(response.map((task) => TaskModel.fromMap(task)));

    setLoadingToggle(false);
    notifyListeners();
  }

  /// Add a new task
  Future<void> addTask() async {
    final userId = _client.auth.currentUser?.id;
    if (userId == null) return;

    setLoadingToggle(true);

    final title = titleController.text.trim();
    final description = descriptionController.text.trim();

    await _client.from(TableName.taskTable).insert([
      {
        'title': title,
        'description': description,
        'status': 'pending',
        'user_id': userId, // Save task under logged-in user
      }
    ]);

    Fluttertoast.showToast(
      msg: 'Task added successfully',
      backgroundColor: Colors.green,
    );

    await fetchTasks();

    titleController.clear();
    descriptionController.clear();
  }

  /// Update a task
  Future<void> updateTask(int taskId) async {
    final userId = _client.auth.currentUser?.id;
    if (userId == null) return;

    final title = titleController.text.trim();
    final description = descriptionController.text.trim();

    await _client
        .from(TableName.taskTable)
        .update({
          'title': title,
          'description': description,
        })
        .eq('id', taskId)
        .eq('user_id', userId); // Ensure task belongs to user

    Fluttertoast.showToast(
      msg: 'Task updated successfully',
      backgroundColor: Colors.green,
    );

    await fetchTasks();
  }

  /// Delete a task
  Future<void> deleteTask(int taskId) async {
    final userId = _client.auth.currentUser?.id;
    if (userId == null) return;

    await _client
        .from(TableName.taskTable)
        .delete()
        .eq('id', taskId)
        .eq('user_id', userId); // Only delete user's task

    Fluttertoast.showToast(
      msg: 'Task deleted successfully',
      backgroundColor: Colors.green,
    );

    await fetchTasks();
  }

  /// Toggle task status between 'pending' and 'completed'
  Future<void> toggleTaskStatus(int taskId, String currentStatus) async {
    final userId = _client.auth.currentUser?.id;
    if (userId == null) return;

    final newStatus = currentStatus == 'pending' ? 'completed' : 'pending';

    await _client
        .from(TableName.taskTable)
        .update({'status': newStatus})
        .eq('id', taskId)
        .eq('user_id', userId); // Secure toggle

    Fluttertoast.showToast(
      msg: 'Task status updated successfully',
      backgroundColor: Colors.green,
    );

    await fetchTasks();
  }
}
