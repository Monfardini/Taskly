import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Início")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Olá!", style: TextStyle(fontSize: 24)),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () => Navigator.pushNamed(context, '/projects'),
              icon: const Icon(Icons.add),
              label: const Text("Novo Projeto"),
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: () => Navigator.pushNamed(context, '/task_detail'),
              icon: const Icon(Icons.add_task),
              label: const Text("Nova Tarefa"),
            ),
            const SizedBox(height: 24),
            const Text("Tarefas Recentes", style: TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Card(
              child: ListTile(
                title: const Text("Corrigir bug do login"),
                subtitle: const Text("Projeto: App Mobile"),
                trailing: const Icon(Icons.arrow_forward),
                onTap: () {
                  Navigator.pushNamed(context, '/task_detail');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
