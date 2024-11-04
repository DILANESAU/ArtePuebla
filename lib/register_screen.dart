import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:artepuebla/ViewModel/RegisterViewModel.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<RegisterViewModel>(context, listen: false);
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.purple],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 40.0),
        child: Center(
          child: SingleChildScrollView( // Agregado el ScrollView
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Crea una cuenta',
                  style: TextStyle(
                    fontSize: 36.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: 'MyCustomFont',
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10.0),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text.rich(
                    TextSpan(
                      text: '¿Ya tienes una cuenta? ',
                      style: TextStyle(color: Colors.white, fontFamily: 'MyCustomFont',),
                      children: [
                        TextSpan(
                          text: 'Inicia sesión aquí.',
                          style: TextStyle(color: Colors.orangeAccent, fontFamily: 'MyCustomFont',),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                const Text(
                  'Nombre',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontFamily: 'MyCustomFont',
                  ),
                ),
                const SizedBox(height: 5.0),
                TextField(
                  onChanged: (value) => viewModel.name = value,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.2),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                const Text(
                  'Primer Apellido',
                  style: TextStyle(color: Colors.white, fontSize: 16.0),
                ),
                const SizedBox(height: 5.0),
                TextField(
                  onChanged: (value) => viewModel.fLastName = value,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.2),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                const Text(
                  'Segundo Apellido',
                  style: TextStyle(color: Colors.white, fontSize: 16.0),
                ),
                const SizedBox(height: 5.0),
                TextField(
                  onChanged: (value) => viewModel.sLastName = value,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.2),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                const Text(
                  'Email',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontFamily: 'MyCustomFont',
                  ),
                ),
                const SizedBox(height: 5.0),
                TextField(
                  onChanged: (value) => viewModel.email = value,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.2),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                const Text(
                  'Contraseña',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontFamily: 'MyCustomFont',
                  ),
                ),
                const SizedBox(height: 5.0),
                TextField(
                  obscureText: true,
                  onChanged: (value) => viewModel.password = value,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.2),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 30.0),
                ElevatedButton(
                  onPressed: () async {
                    final success = await viewModel.registerUser();
                    if (success) {
                      Navigator.pop(context);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Error al registrar el usuario'))
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[800],
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: const Text(
                    'Registrarse',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontFamily: 'MyCustomFont',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}