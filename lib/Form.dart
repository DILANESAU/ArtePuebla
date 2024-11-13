// UserProfileScreen
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Galeria.dart';
import 'package:flutter_application_1/Home.dart';
import 'package:flutter_application_1/museum_screen.dart';
import 'package:flutter_application_1/user_profile_screen.dart';
import 'Favoritos.dart';
import 'Taller.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  late PageController _pageController;
  int _currentPage = 2;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 2);

    // Temporizador
    _timer = Timer.periodic(const Duration(seconds: 4), (Timer timer) {
      if (_currentPage < 2) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Galería",
        home: Scaffold(
          appBar: AppBar(
            title: const Center(
              child: Text(
                "Arte Puebla",
                style: TextStyle(fontFamily: 'MyCustomFont'),
              ),
            ),
          ),
          drawer: MenuLateral(),
          body: ListView(
            children: [
              const SizedBox(height: 30.0),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0), // Ajusta los márgenes horizontales
                child: Card(
                  elevation: 8.0, // Añade una elevación al formulario
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Center(
                            child: const Text(
                              'Agrega un evento',
                              style: TextStyle(
                                color: Color.fromARGB(255, 184, 181, 181),
                                fontSize: 25.0,
                                fontFamily: 'MyCustomFont',
                              ),
                            ),
                          ),
                          const Text(
                            'Nombre',
                            style: TextStyle(
                              color: Color.fromARGB(255, 183, 181,
                                  181), // Cambié el color del texto a negro para mejor visibilidad
                              fontSize: 16.0,

                              fontFamily: 'MyCustomFont',
                            ),
                          ),
                          const SizedBox(height: 5.0),
                          TextFormField(
                            decoration: InputDecoration(
                              filled: true,
                              fillColor:
                                  const Color.fromARGB(255, 231, 190, 233)
                                      .withOpacity(0.2),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor, ingrese datos';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 30.0),
                          const Text(
                            'Nombre',
                            style: TextStyle(
                              color: Color.fromARGB(255, 183, 181,
                                  181), // Cambié el color del texto a negro para mejor visibilidad
                              fontSize: 16.0,

                              fontFamily: 'MyCustomFont',
                            ),
                          ),
                          const SizedBox(height: 5.0),
                          TextFormField(
                            decoration: InputDecoration(
                              filled: true,
                              fillColor:
                                  const Color.fromARGB(255, 231, 190, 233)
                                      .withOpacity(0.2),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor, ingrese datos';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20.0),
                          const Text(
                            'Nombre',
                            style: TextStyle(
                              color: Color.fromARGB(255, 183, 181,
                                  181), // Cambié el color del texto a negro para mejor visibilidad
                              fontSize: 16.0,

                              fontFamily: 'MyCustomFont',
                            ),
                          ),
                          const SizedBox(height: 5.0),
                          TextFormField(
                            decoration: InputDecoration(
                              filled: true,
                              fillColor:
                                  const Color.fromARGB(255, 231, 190, 233)
                                      .withOpacity(0.2),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor, ingrese datos';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20.0),
                          ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                // Lógica del botón de inicio de sesión
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => GaleriaScreen()),
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 156, 39, 176),
                              padding:
                                  const EdgeInsets.symmetric(vertical: 15.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                            child: const Text(
                              'Agregar Galería',
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
              ),
              const SizedBox(height: 20.0),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: '',
              ),
            ],
            backgroundColor: Colors.deepPurple,
            selectedItemColor: Colors.white,
            currentIndex: _currentPage,
            onTap: (index) {
              if (index == 2) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const UserProfileScreen()),
                );
              } else if (index == 0) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const FavoritosScreen()),
                );
              } else if (index == 1) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                );
              } else {
                setState(() {
                  _currentPage = index;
                  _pageController.jumpToPage(_currentPage);
                });
              }
            },
          ),
        ));
  }
}

class MenuLateral extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          Ink(
            color: const Color.fromARGB(255, 114, 110, 205),
            child: const ListTile(
              title: Text(
                "Arte Puebla",
                style:
                    TextStyle(color: Colors.white, fontFamily: 'MyCustomFont'),
              ),
            ),
          ),
          _buildMenuButton(
            context,
            icon: Icons.home,
            label: "Inicio",
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (BuildContext) => const HomeScreen()),
              );
            },
          ),
          _buildMenuButton(
            context,
            icon: Icons.museum,
            label: "Museos",
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(
                MaterialPageRoute(builder: (BuildContext) => MuseumScreen()),
              );
            },
          ),
          _buildMenuButton(
            context,
            icon: Icons.favorite,
            label: "Favoritos",
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (BuildContext) => const FavoritosScreen()),
              );
            },
          ),
          _buildMenuButton(
            context,
            icon: Icons.brush,
            label: "Taller",
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (BuildContext) => const TallerScreen()),
              );
            },
          ),
          _buildMenuButton(
            context,
            icon: Icons.palette,
            label: "Galería",
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (BuildContext) => const GaleriaScreen()),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMenuButton(BuildContext context,
      {required IconData icon,
      required String label,
      required VoidCallback onTap}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 16.0),
      child: ElevatedButton.icon(
        onPressed: onTap,
        icon: Icon(icon),
        label: Text(label),
      ),
    );
  }
}
