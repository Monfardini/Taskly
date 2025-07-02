import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/project_model.dart';

class ProjectService {
  final CollectionReference projectsCollection =
      FirebaseFirestore.instance.collection('projects');

  Future<void> createProject(String name) async {
    await projectsCollection.add({
      'name': name,
      'createdAt': DateTime.now().toIso8601String(),
    });
  }

  Stream<List<Project>> getProjects() {
    return projectsCollection
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return Project.fromMap(doc.id, doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }
}
