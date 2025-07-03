import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/task_model.dart';

class TaskListScreen extends StatefulWidget {
  final String projectId;
  final String projectTitle;

  const TaskListScreen({
    super.key,
    required this.projectId,
    required this.projectTitle,
  });

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  Future<List<TaskModel>> _fetchTasks() async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('tasks')
        .where('projectId', isEqualTo: widget.projectId)
        .get();

    return querySnapshot.docs
        .map((doc) => TaskModel.fromMap(doc.data(), doc.id))
        .toList();
  }

  Future<void> _addTaskDialog() async {
    final titleCtrl = TextEditingController();
    final descCtrl = TextEditingController();

    await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Nova Tarefa'),
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
              if (title.isEmpty || desc.isEmpty) return;

              await FirebaseFirestore.instance.collection('tasks').add({
                'title': title,
                'description': desc,
                'completed': false,
                'projectId': widget.projectId,
              });

              Navigator.pop(ctx);
              setState(() {});
            },
            child: const Text('Criar'),
          ),
        ],
      ),
    );
  }

  Future<void> _toggleComplete(TaskModel task) async {
    await FirebaseFirestore.instance
        .collection('tasks')
        .doc(task.id)
        .update({'completed': !task.completed});
    setState(() {});
  }

  Future<void> _deleteTask(TaskModel task) async {
    await FirebaseFirestore.instance.collection('tasks').doc(task.id).delete();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tarefas - ${widget.projectTitle}'),
      ),
      body: FutureBuilder<List<TaskModel>>(
        future: _fetchTasks(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text('Erro ao carregar tarefas'));
          }
          final tasks = snapshot.data ?? [];
          if (tasks.isEmpty) {
            return const Center(child: Text('Nenhuma tarefa encontrada'));
          }

          return ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final task = tasks[index];
              return Dismissible(
                key: Key(task.id),
                background: Container(color: Colors.red),
                onDismissed: (_) => _deleteTask(task),
                child: ListTile(
                  title: Text(
                    task.title,
                    style: TextStyle(
                      decoration: task.completed
                          ? TextDecoration.lineThrough
                          : null,
                    ),
                  ),
                  subtitle: Text(task.description),
                  trailing: IconButton(
                    icon: Icon(
                      task.completed
                          ? Icons.check_circle
                          : Icons.radio_button_unchecked,
                      color: task.completed ? Colors.green : null,
                    ),
                    onPressed: () => _toggleComplete(task),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTaskDialog,
        child: const Icon(Icons.add),
        tooltip: 'Adicionar tarefa',
      ),
    );
  }
}
