import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProjectScreen extends StatefulWidget {
  const ProjectScreen({super.key});

  @override
  State<ProjectScreen> createState() => _ProjectScreenState();
}

class _ProjectScreenState extends State<ProjectScreen> {
  final _projectNameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _auth = FirebaseAuth.instance;

  Future<void> _createProject() async {
    try {
      await FirebaseFirestore.instance.collection('projects').add({
        'name': _projectNameController.text.trim(),
        'description': _descriptionController.text.trim(),
        'userId': _auth.currentUser?.uid,
        'createdAt': Timestamp.now(),
      });

      Navigator.pop(context); // Voltar após salvar
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erro: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Novo Projeto')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: _projectNameController, decoration: const InputDecoration(labelText: 'Nome do Projeto')),
            TextField(controller: _descriptionController, decoration: const InputDecoration(labelText: 'Descrição')),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await _createProject();
                if (mounted) {
                  Navigator.pushNamedAndRemoveUntil(context, '/main', (route) => false);
                }
              },
              child: const Text('Criar Projeto'),
            ),
          ],
        ),
      ),
    );
  }
}
