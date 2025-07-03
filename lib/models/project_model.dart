class ProjectModel {
  final String id;
  final String title;
  final String description;

  ProjectModel({
    required this.id,
    required this.title,
    required this.description,
  });

  factory ProjectModel.fromMap(Map<String, dynamic> data, String documentId) {
    return ProjectModel(
      id: documentId,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
    };
  }
}
