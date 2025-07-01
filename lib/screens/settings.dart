import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Configurações")),
      body: ListView(
        children: [
          ListTile(title: const Text("Editar Perfil"), onTap: () {}),
          ListTile(title: const Text("Modo Escuro"), onTap: () {}),
          ListTile(title: const Text("Sair"), onTap: () {}),
        ],
      ),
    );
  }
}
