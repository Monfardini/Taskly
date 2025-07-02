import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool darkMode = false;

  void _logout() async {
    await FirebaseAuth.instance.signOut();
    if (mounted) {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Configurações")),
      body: ListView(
        children: [
          const ListTile(
            leading: Icon(Icons.person),
            title: Text("Editar Perfil"),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          SwitchListTile(
            title: const Text("Modo escuro"),
            value: darkMode,
            onChanged: (value) {
              setState(() => darkMode = value);
              // implementar tema escuro global depois
            },
            secondary: const Icon(Icons.dark_mode),
          ),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text("Sair", style: TextStyle(color: Colors.red)),
            onTap: _logout,
          )
        ],
      ),
    );
  }
}
