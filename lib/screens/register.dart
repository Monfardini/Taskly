import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Criar conta", style: TextStyle(fontSize: 28)),
            const TextField(decoration: InputDecoration(labelText: "Nome")),
            const TextField(decoration: InputDecoration(labelText: "Email")),
            const TextField(
              decoration: InputDecoration(labelText: "Senha"),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              child: const Text("Registrar"),
            ),
          ],
        ),
      ),
    );
  }
}