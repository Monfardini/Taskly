  import 'package:flutter/material.dart';

  class DashboardScreen extends StatelessWidget {
    const DashboardScreen({super.key});

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(title: const Text("Meus Projetos")),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: List.generate(
            5,
            (index) => Card(
              child: ListTile(
                title: Text("Projeto ${index + 1}"),
                subtitle: const Text("3 tarefas pendentes"),
                onTap: () => Navigator.pushNamed(context, '/project'),
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.add),
        ),
      );
    }
  }
