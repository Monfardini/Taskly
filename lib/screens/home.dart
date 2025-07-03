import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/project_model.dart';
import 'tasks_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<List<ProjectModel>> _fetchProjects() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return [];

    final querySnapshot = await FirebaseFirestore.instance
        .collection('projects')
        .where('ownerId', isEqualTo: uid)
        .get();

    return querySnapshot.docs
        .map((doc) => ProjectModel.fromMap(doc.data(), doc.id))
        .toList();
  }

  Future<void> _logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meus Projetos'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => _logout(context),
            tooltip: 'Sair',
          )
        ],
      ),
      body: FutureBuilder<List<ProjectModel>>(
        future: _fetchProjects(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text('Erro ao carregar projetos'));
          }
          final projects = snapshot.data ?? [];
          if (projects.isEmpty) {
            return const Center(child: Text('Nenhum projeto encontrado'));
          }
          return ListView.builder(
            itemCount: projects.length,
            itemBuilder: (context, index) {
              final project = projects[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: ListTile(
                  title: Text(project.title),
                  subtitle: Text(project.description),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  leading: const Icon(Icons.folder_open),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => TaskListScreen(
                          projectId: project.id,
                          projectTitle: project.title,
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Adicionar Projeto',
        onPressed: () {
          _showAddProjectDialog(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddProjectDialog(BuildContext context) {
    final titleCtrl = TextEditingController();
    final descCtrl = TextEditingController();
    final uid = FirebaseAuth.instance.currentUser?.uid;

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Novo Projeto'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleCtrl,
              decoration: const InputDecoration(labelText: 'Título'),
            ),
            TextField(
              controller: descCtrl,
              decoration: const InputDecoration(labelText: 'Descrição'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () async {
              final title = titleCtrl.text.trim();
              final desc = descCtrl.text.trim();
              if (title.isEmpty || desc.isEmpty || uid == null) return;

              await FirebaseFirestore.instance.collection('projects').add({
                'title': title,
                'description': desc,
                'ownerId': uid,
              });

              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Projeto criado com sucesso')));
              (context as Element).markNeedsBuild();
            },
            child: const Text('Salvar'),
          ),
        ],
      ),
    );
  }
}
