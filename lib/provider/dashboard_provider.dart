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

  /// Fetch tasks from Supabase
  Future<void> fetchTasks() async {
    setLoadingToggle(true);

    final response = await _client.from(TableName.taskTable).select();

    _tasks =
        List<TaskModel>.from(response.map((task) => TaskModel.fromMap(task)));

    setLoadingToggle(false);

    print('Tasks : $_tasks');
    notifyListeners();
  }

  /// Add a new task
  Future<void> addTask() async {
    setLoadingToggle(true);

    final title = titleController.text.trim();
    final description = descriptionController.text.trim();

    final response = await _client.from(TableName.taskTable).insert([
      {
        'title': title,
        'description': description,
        'status': 'pending',
      }
    ]);

    Fluttertoast.showToast(
      msg: 'Task added successfully',
      backgroundColor: Colors.green,
    );

    await fetchTasks();

    titleController.clear();
    descriptionController.clear();

    return response;
  }

  /// Update a task
  Future<void> updateTask(int taskId) async {
    final title = titleController.text.trim();
    final description = descriptionController.text.trim();

    final response = await _client.from(TableName.taskTable).update(
      {
        'title': title,
        'description': description,
      },
    ).eq('id', taskId);

    Fluttertoast.showToast(
      msg: 'Task updated successfully',
      backgroundColor: Colors.green,
    );

    await fetchTasks();

    return response;
  }

  /// Delete a task
  Future<void> deleteTask(int taskId) async {
    final response =
        await _client.from(TableName.taskTable).delete().eq('id', taskId);

    Fluttertoast.showToast(
      msg: 'Task deleted successfully',
      backgroundColor: Colors.green,
    );

    await fetchTasks();

    return response;
  }

  // Toggle task status between 'pending' and 'completed'
  Future<void> toggleTaskStatus(int taskId, String currentStatus) async {
    final newStatus = currentStatus == 'pending' ? 'completed' : 'pending';

    final response = await _client
        .from(TableName.taskTable)
        .update({'status': newStatus}).eq('id', taskId);

    Fluttertoast.showToast(
      msg: 'Task Status updated successfully',
      backgroundColor: Colors.green,
    );

    await fetchTasks();

    return response;
  }
}
