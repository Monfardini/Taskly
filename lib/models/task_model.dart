class TaskModel {
  final String id;
  final String title;
  final String description;
  final bool completed;
  final String projectId;

  TaskModel({
    required this.id,
    required this.title,
    required this.description,
    required this.completed,
    required this.projectId,
  });

  factory TaskModel.fromMap(Map<String, dynamic> data, String documentId) {
    return TaskModel(
      id: documentId,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      completed: data['completed'] ?? false,
      projectId: data['projectId'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'completed': completed,
      'projectId': projectId,
    };
  }
}
