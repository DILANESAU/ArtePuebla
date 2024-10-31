import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_application_1/museum_screen.dart';
import 'Favoritos.dart';
import 'Taller.dart';
import 'user_profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late PageController _pageController;
  int _currentPage = 0;
  late Timer _timer;
  List<bool> _isExpanded = [false, false, false]; // Expancion de la tarjeta 
  List<dynamic> _museums = []; //Lista de informacion API

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    _fetchMuseumData(); //Funcion API

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

    Future<void> _fetchMuseumData() async {
    final url = Uri.parse(''); // URL del API
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        setState(() {
          _museums = json.decode(response.body); // Conversion a JSON
        });
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error de conexión: $e');
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Arte Puebla",
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
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: 200,
                  margin: const EdgeInsets.all(2.0),
                  child: PageView(
                    controller: _pageController,
                    onPageChanged: (index) {
                      _currentPage = index;
                    },
                    children: [
                      _buildImageCarousel('assets/images/Museo_Amparo_Puebla.jpg'),
                      _buildImageCarousel('assets/images/Museo_Evolucion_Puebla.jpg'),
                      _buildImageCarousel('assets/images/Museo_Ferrocarril_Puebla.jpg'),
                    ],
                  ),
                ),
                const Text(
                  "Museos en Puebla",
                  style: TextStyle(
                    fontSize: 24,
                    fontFamily: 'MyCustomFont',
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        offset: Offset(2.0, 2.0),
                        blurRadius: 3.0,
                        color: Color.fromARGB(137, 0, 0, 0),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              '¿A dónde quiere ir?',
              style: TextStyle(fontSize: 18, fontFamily: 'MyCustomFont'),
            ),
            const SizedBox(height: 8),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                style: TextStyle(fontFamily: 'MyCustomFont'),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Buscar museo...',
                  prefixIcon: Icon(Icons.search),
                ),
              ),
            ),
          const SizedBox(height: 16),
           Expanded(
            child: _museums.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: _museums.length,
                    itemBuilder: (context, index) {
                      final museum = _museums[index];
                      return _buildMuseumCard(
                        context,
                        index,
                        museum['title'],
                        museum['description'],
                        museum['price'].toString(),
                        museum['image_url'],
                        museum['extended_description'],
                      );
                    },
                  ),
            ),
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
                MaterialPageRoute(builder: (context) => const UserProfileScreen()),
              );
            } else {
              setState(() {
                _currentPage = index;
                _pageController.jumpToPage(_currentPage);
              });
            }
          },
        ),
      ),
    );
  }

  Widget _buildImageCarousel(String imagePath) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildMuseumCard(BuildContext context, int index, String title,
      String description, String price, String imageUrl, String extendedDescription) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isExpanded[index] = !_isExpanded[index];
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        height: _isExpanded[index] ? 250 : 150,
        child: Card(
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(imageUrl),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold, fontFamily: 'MyCustomFont'),
                        ),
                        const SizedBox(height: 4),
                        Text(description, maxLines: 2, overflow: TextOverflow.ellipsis),
                        const SizedBox(height: 8),
                        Text('\$$price',
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold, fontFamily: 'MyCustomFont',)),
                      ],
                    ),
                  ),
                ],
              ),
              if (_isExpanded[index])
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    extendedDescription,
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
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
                style: TextStyle(color: Colors.white, fontFamily: 'MyCustomFont'),
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
                MaterialPageRoute(builder: (BuildContext) => const HomeScreen()),
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
                MaterialPageRoute(builder: (BuildContext) => const FavoritosScreen()),
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
                MaterialPageRoute(builder: (BuildContext) => const TallerScreen()),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMenuButton(BuildContext context,
      {required IconData icon, required String label, required VoidCallback onTap}) {
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