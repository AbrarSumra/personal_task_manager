class TaskModel {
  final int? id;
  final String? title;
  final String? description;
  final String? status;

  TaskModel({
    this.id,
    this.title,
    this.description,
    this.status,
  });

  // Convert a Task object into a map (for Supabase insertion/updating)
  Map<String, dynamic> toMap() {
    return {
      'id': id ?? "",
      'title': title ?? "",
      'description': description ?? "",
      'status': status ?? "",
    };
  }

  // Convert a map into a Task object
  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      status: map['status'],
    );
  }
}
