import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Dashboard")),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: List.generate(
          5,
          (index) => Card(
            child: ListTile(
              title: Text("Projeto ${index + 1}"),
              subtitle: const Text("3 tarefas pendentes"),
              onTap: () {
                // Aqui pode navegar para detalhes, por enquanto só exemplo
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Projeto ${index + 1} selecionado')),
                );
              },
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Você pode implementar ação aqui para criar novo projeto direto do dashboard
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
