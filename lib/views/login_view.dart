import 'package:artepuebla/services/auth_services.dart';
import 'package:artepuebla/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:artepuebla/viewmodels/login_viewmodel.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      body: ChangeNotifierProvider(
        create: (_) => LoginViewmodel(),
        child: Consumer<LoginViewmodel>(
          builder: (context, viewModel, child) {
            return Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color.fromARGB(255, 86, 7, 12), Colors.white],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 60.0),
                      const Text(
                        '¡Bienvenido!',
                        style: TextStyle(
                          fontSize: 32.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10.0),
                      const Text(
                        'Inicia sesión para continuar',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.white70,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 40.0),
                      Form(
                        key: formKey,
                        child: Column(
                          children: [
                            _buildTextField(
                              label: 'Correo Electrónico',
                              hintText: 'Ingresa tu email',
                              onChanged: (value) {
                                viewModel.email = value;
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Por favor, ingresa tu correo electrónico';
                                } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                                    .hasMatch(value)) {
                                  return 'Por favor, ingresa un correo válido';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20.0),
                            _buildTextField(
                              label: 'Contraseña',
                              hintText: 'Ingresa tu contraseña',
                              obscureText: true,
                              onChanged: (value) {
                                viewModel.password = value;
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Por favor, ingresa tu contraseña';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 30.0),
                            _buildButton(
                              text: 'Iniciar Sesión',
                              onPressed: () async {
                                if (formKey.currentState!.validate()) {
                                  final success = await viewModel.loginUser();
                                  if (success) {
                                    Navigator.pushNamed(context, '/home');
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          'Error de inicio de sesión. Verifica tus credenciales.',
                                        ),
                                      ),
                                    );
                                  }
                                }
                              },
                            ),
                            const SizedBox(height: 15.0),
                            _buildButton(
                              text: 'Iniciar con Google',
                              icon: Icons.g_mobiledata,
                              backgroundColor: Colors.redAccent,
                              onPressed: () async {
                                final authService = AuthService();
                                final user = await authService.signInWithGoogle();
                                if (user != null) {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(builder: (context) => const HomeScreen())
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Inicio de sesion fallido'))
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/register');
                        },
                        child: const Text.rich(
                          TextSpan(
                            text: '¿No tienes cuenta? ',
                            style: TextStyle(color: Colors.white70),
                            children: [
                              TextSpan(
                                text: 'Regístrate aquí.',
                                style: TextStyle(color: Colors.orangeAccent),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // Campo de texto con onChanged añadido
  Widget _buildTextField({
    required String label,
    required String hintText,
    required String? Function(String?) validator,
    required ValueChanged<String> onChanged,
    bool obscureText = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 14.0,
          ),
        ),
        const SizedBox(height: 5.0),
        TextFormField(
          decoration: InputDecoration(
            hintText: hintText,
            filled: true,
            fillColor: Colors.white.withOpacity(0.1),
            hintStyle: const TextStyle(color: Colors.white54),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide.none,
            ),
          ),
          obscureText: obscureText,
          validator: validator,
          onChanged: onChanged,
        ),
      ],
    );
  }

  // Botón reutilizable
  Widget _buildButton({
    required String text,
    required VoidCallback onPressed,
    IconData? icon,
    Color backgroundColor = const Color(0xFF4A90E2),
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null)
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Icon(icon, color: Colors.white),
            ),
          Text(
            text,
            style: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
