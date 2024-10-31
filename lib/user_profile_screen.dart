import 'package:flutter/material.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Perfil de Usuario"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Imagen de usuario
            CircleAvatar(
              radius: 80,
              backgroundImage: AssetImage('assets/images/user_profile.jpg'), 
            ),
            const SizedBox(height: 16),
            // Nombre del usuario
            const Text(
              "ARLETTE PEREZ",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.purple,
              ),
            ),
            const SizedBox(height: 32),
            // Campos de información del usuario
            _buildUserInfoField("NOMBRE"),
            const SizedBox(height: 16),
            _buildUserInfoField("CONTRASEÑA"),
            const SizedBox(height: 16),
            _buildUserInfoField("EMAIL"),
          ],
        ),
      ),
    );
  }

  Widget _buildUserInfoField(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: TextField(
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(
            color: Colors.purple,
          ),
          filled: true,
          fillColor: Colors.orangeAccent.withOpacity(0.2),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
