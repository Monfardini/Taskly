import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileSetupScreen extends StatefulWidget {
  const ProfileSetupScreen({super.key});
  @override
  State<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen> {
  final _nameCtrl = TextEditingController();
  bool _loading = false, _errorVisible = false;

  Future<void> _saveProfile() async {
    final user = FirebaseAuth.instance.currentUser;
    final name = _nameCtrl.text.trim();
    if (user == null || name.isEmpty) {
      setState(() => _errorVisible = true);
      return;
    }
    setState(() => _loading = true);

    await FirebaseFirestore.instance.collection('users')
      .doc(user.uid).set({
        'name': name,
        'email': user.email,
        'photoUrl': '',
      });

    if (!mounted) return;
    Navigator.pushReplacementNamed(context, '/main');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Complete seu perfil')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _nameCtrl,
              decoration: const InputDecoration(
                labelText: 'Nome',
                prefixIcon: Icon(Icons.person),
              ),
            ),
            const SizedBox(height: 20),
            if (_errorVisible)
              const Text('Informe seu nome!',
                  style: TextStyle(color: Colors.red)),
            ElevatedButton.icon(
              onPressed: _loading ? null : _saveProfile,
              icon: const Icon(Icons.check),
              label: _loading
                ? const CircularProgressIndicator(color: Colors.white)
                : const Text('Salvar Perfil'),
            )
          ],
        ),
      ),
    );
  }
}
