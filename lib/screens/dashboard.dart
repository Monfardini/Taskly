import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  Future<int> _countProjects() async {
    final snapshot = await FirebaseFirestore.instance.collection('projects').get();
    return snapshot.docs.length;
  }

  Future<int> _countTasks() async {
    final snapshot = await FirebaseFirestore.instance.collection('tasks').get();
    return snapshot.docs.length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.pushNamed(context, '/settings');
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FutureBuilder<int>(
              future: _countProjects(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const CircularProgressIndicator();
                return Text(
                  'Projetos: ${snapshot.data}',
                  style: Theme.of(context).textTheme.titleLarge,
                );
              },
            ),
            const SizedBox(height: 16),
            FutureBuilder<int>(
              future: _countTasks(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const CircularProgressIndicator();
                return Text(
                  'Tarefas: ${snapshot.data}',
                  style: Theme.of(context).textTheme.titleLarge,
                );
              },
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, '/project');
              },
              icon: const Icon(Icons.add),
              label: const Text('Novo Projeto'),
            ),
          ],
        ),
      ),
    );
  }
}
