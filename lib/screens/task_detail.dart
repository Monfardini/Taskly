import 'package:flutter/material.dart';

class TaskDetailScreen extends StatelessWidget {
  const TaskDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Detalhes da Tarefa")),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Título: Criar interface", style: TextStyle(fontSize: 20)),
            SizedBox(height: 8),
            Text("Descrição: Usar Figma para desenhar layout"),
            SizedBox(height: 8),
            Text("Responsável: Gabriel"),
          ],
        ),
      ),
    );
  }
}