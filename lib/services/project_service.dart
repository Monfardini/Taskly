import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/project_model.dart';

class ProjectService {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  Stream<List<ProjectModel>> getProjects() {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return const Stream.empty();

    return _firestore
        .collection('projects')
        .where('ownerId', isEqualTo: uid)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => ProjectModel.fromMap(doc.data(), doc.id))
            .toList());
  }

  Future<void> createProject(String title) async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return;

    await _firestore.collection('projects').add({
      'title': title,
      'description': 'Novo projeto criado',
      'ownerId': uid,
    });
  }
}
