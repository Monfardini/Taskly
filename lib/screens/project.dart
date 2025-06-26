import 'package:flutter/material.dart';

class ProjectScreen extends StatelessWidget {
  const ProjectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Projeto X")),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text("Tarefas", style: TextStyle(fontSize: 20)),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 3,
              itemBuilder: (context, index) => ListTile(
                title: Text("Tarefa ${index + 1}"),
                subtitle: const Text("Em andamento"),
                onTap: () => Navigator.pushNamed(context, '/task'),
              ),
            ),
          )
        ],
      ),
    );
  }
}
