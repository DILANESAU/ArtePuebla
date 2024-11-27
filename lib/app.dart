import 'package:artepuebla/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:artepuebla/views/login_view.dart';
import 'package:artepuebla/views/register_view.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Arte',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        // Configuración adicional de temas
      ),
      //home: LoginScreen();
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginScreen(), // Pantalla de login
        '/register': (context) => const RegisterScreen(), //Pantalla de registro
        '/home': (context) => const HomeScreen(), //Pantala Principal
      },
    );
  }
}
