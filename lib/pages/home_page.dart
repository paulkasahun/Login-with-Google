import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Homepage extends StatelessWidget {
  Homepage({super.key});
  final user = FirebaseAuth.instance.currentUser!;

  signUserout() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: signUserout,
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Center(
        child: Text(
          "Loged In as::${user.email}",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
      ),
    );
  }
}
