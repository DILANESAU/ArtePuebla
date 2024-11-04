import 'package:flutter/material.dart';
import 'package:artepuebla/Home.dart';
import 'package:artepuebla/ViewModel/LoginViewModel.dart';
import 'package:artepuebla/ViewModel/RegisterViewModel.dart';
import 'package:provider/provider.dart';
import 'register_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:artepuebla/museum_screen.dart';
import 'package:artepuebla/ViewModel/museumScreen.dart';
void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginViewModel()),
        ChangeNotifierProvider(create: (_) => RegisterViewModel()),
        ChangeNotifierProvider(create: (_) => MuseumViewModel()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/home': (context) => const HomeScreen(),
        '/museumScreen': (context) => const MuseumScreen(),
      },
    );
  }
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final viewModel = Provider.of<LoginViewModel>(context, listen: false);

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
          child: ListView(
            shrinkWrap: true,
            children: [
              const SizedBox(height: 80.0),
              const Text(
                'Bienvenido',
                style: TextStyle(
                  fontSize: 36.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: 'MyCustomFont',
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30.0),
              Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Email',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        fontFamily: 'MyCustomFont',
                        ),
                      ),
                      const SizedBox(height: 5.0),
                      TextFormField(
                        onChanged: (value) => viewModel.email = value,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.2),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, ingrese su email';
                        } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                          return 'Por favor, ingrese un email válido';
                        }
                        return null;
                        },
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
                      TextFormField(
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
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, ingrese su contraseña';
                        } 
                        return null;
                      },
                    ),
                      const SizedBox(height: 30.0),
                      ElevatedButton(
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            //Logica del boton inicio de Sesion
                            final isLogged = await viewModel.loginUser();
                            if(isLogged) {
                              Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const HomeScreen()),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("Email o contraseñas incorrectos")),
                              );
                            }
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
                          'Iniciar Sesión',
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
              const SizedBox(height: 20.0),
              ElevatedButton.icon(
              onPressed: () {
                // Lógica para iniciar sesión con Google
              },
              icon: SvgPicture.asset(
                'assets/images/google_color_icon.svg',
                height: 24.0,
                width: 24.0,
              ),
              label: const Text(
                'Iniciar Sesión con Google',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontFamily: 'MyCustomFont',
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[800],
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
              const SizedBox(height: 20.0),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/register');
                },
                child: const Text.rich(
                  TextSpan(
                    text: '¿No estás registrado? ',
                    style: TextStyle(color: Colors.white, fontFamily: 'MyCustomFont',),
                    children: [
                      TextSpan(
                        text: 'Regístrate aquí.',
                        style: TextStyle(color: Colors.orangeAccent, fontFamily: 'MyCustomFont',),
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
  }
}
