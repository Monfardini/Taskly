import 'package:flutter/material.dart';
import '../services/project_service.dart';
import '../models/project_model.dart';

class ProjectListScreen extends StatefulWidget {
  const ProjectListScreen({super.key});

  @override
  State<ProjectListScreen> createState() => _ProjectListScreenState();
}

class _ProjectListScreenState extends State<ProjectListScreen> {
  final ProjectService _projectService = ProjectService();

  void _showCreateProjectDialog() {
    final TextEditingController controller = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Novo Projeto"),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(labelText: "Nome do Projeto"),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancelar"),
          ),
          ElevatedButton(
            onPressed: () async {
              if (controller.text.isNotEmpty) {
                await _projectService.createProject(controller.text);
                if (mounted) Navigator.pop(context);
              }
            },
            child: const Text("Criar"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Projetos")),
      body: StreamBuilder<List<Project>>(
        stream: _projectService.getProjects(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text("Erro ao carregar projetos"));
          }
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final projects = snapshot.data!;
          if (projects.isEmpty) {
            return const Center(child: Text("Nenhum projeto ainda"));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: projects.length,
            itemBuilder: (_, index) {
              final project = projects[index];
              return ListTile(
                leading: const Icon(Icons.folder),
                title: Text(project.name),
                subtitle: Text("Criado em ${project.createdAt.toLocal()}"),
                onTap: () {
                  // Aqui você pode redirecionar para as tarefas do projeto
                  Navigator.pushNamed(context, '/task_detail', arguments: project.id);
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showCreateProjectDialog,
        icon: const Icon(Icons.add),
        label: const Text("Novo Projeto"),
      ),
    );
  }
}
