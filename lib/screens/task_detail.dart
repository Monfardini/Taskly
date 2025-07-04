// lib/screens/task_detail_screen.dart
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TaskDetailScreen extends StatefulWidget {
  final String projectId;
  const TaskDetailScreen({super.key, required this.projectId});

  @override
  State<TaskDetailScreen> createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends State<TaskDetailScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _auth = FirebaseAuth.instance;

  Future<void> _createTask() async {
    try {
      await FirebaseFirestore.instance.collection('tasks').add({
        'title': _titleController.text.trim(),
        'description': _descriptionController.text.trim(),
        'projectId': widget.projectId,
        'userId': _auth.currentUser?.uid,
        'createdAt': Timestamp.now(),
        'status': 'pendente',
      });

      Navigator.pop(context); // Voltar após salvar
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erro: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nova Tarefa')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: _titleController, decoration: const InputDecoration(labelText: 'Título')),
            TextField(controller: _descriptionController, decoration: const InputDecoration(labelText: 'Descrição')),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: _createTask, child: const Text('Salvar Tarefa')),
          ],
        ),
      ),
    );
  }
}
