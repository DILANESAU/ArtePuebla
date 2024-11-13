import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Form.dart';
import 'package:flutter_application_1/Taller.dart';
import 'package:flutter_application_1/museum_screen.dart';
import 'package:flutter_application_1/user_profile_screen.dart';
import 'Favoritos.dart';
import 'Home.dart';

class GaleriaScreen extends StatefulWidget {
  const GaleriaScreen({super.key});

  @override
  _GaleriaScreenState createState() => _GaleriaScreenState();
}

class _GaleriaScreenState extends State<GaleriaScreen> {
  late PageController _pageController;
  int _currentPage = 0;
  late Timer _timer;
  List<bool> _isExpanded = [false, false, false]; // Expancion de la tarjeta

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
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
        body: ListView(
          // crossAxisAlignment: CrossAxisAlignment.center,
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
                      _buildImageCarousel(
                          'assets/images/Museo_Amparo_Puebla.jpg'),
                      _buildImageCarousel(
                          'assets/images/Museo_Evolucion_Puebla.jpg'),
                      _buildImageCarousel(
                          'assets/images/Museo_Ferrocarril_Puebla.jpg'),
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
            // Positioned(
            //   bottom: 16.0,
            //   right: 50.0,
            //   child: FloatingActionButton(
            //     onPressed: () {
            //       Navigator.push(
            //         context,
            //         MaterialPageRoute(builder: (context) => const FormScreen()),
            //       );
            //     },
            //     child: const Icon(Icons.add,size: 24,),
            //     backgroundColor: Colors.deepPurple,
            //     tooltip:'Agregar Galería',

            //   ),
            // ),
            Align(
              alignment: Alignment
                  .bottomRight, // Alinea el botón a la esquina inferior derecha
              child: Container(
                margin: EdgeInsets.all(
                    16.0), // Añade un margen de 16 píxeles en todos los lados
                child: FloatingActionButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const FormScreen()),
                    );
                  },
                  child: const Icon(Icons.add, size: 24),
                  backgroundColor: Colors.deepPurple,
                  tooltip: 'Agregar Galería',
                ),
              ),
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
            Column(
              //    shrinkWrap: true,
              children: [
                _buildMuseumCard(
                  context,
                  0,
                  'Museo de la Evolución',
                  'Este museo explora la historia evolutiva de la Tierra y sus seres vivos.',
                  '45.00',
                  'assets/images/fachadamuseoevo.jpg',
                  'Este museo explora los 14 mil millones de años que ha experimentado el planeta tierra, comenzando con los organismos unicelulares del periodo Arcaico y las especies animales. Sin embargo, en este museo también hallarás temáticas como el calentamiento global, la responsabilidad humana y los cambios de temperatura mundial, con el propósito de reflexionar sobre la especie humana y su lugar en la evolución.',
                ),
                _buildMuseumCard(
                  context,
                  1,
                  'Museo Amparo',
                  'Este museo presenta una colección de arte prehispánico y contemporáneo.',
                  '85.00',
                  'assets/images/fachadamuseoamapa.jpg',
                  'Considerado uno de los centros culturales y de exhibición más importantes de México. Cuenta con salas para la exhibición de su acervo de arte prehispánico, uno de los más importantes en México en una institución privada. Además de la colección de obras de arte virreinal y de los siglos XIX y XX, presenta un programa permanente de exposiciones temporales nacionales e internacionales, al igual que un intenso programa de actividades académicas, artísticas, educativas y lúdicas dirigidas a todo tipo de públicos.',
                ),
                _buildMuseumCard(
                  context,
                  2,
                  'Museo del Ferrocarril',
                  'Este museo recorre la historia del ferrocarril en México.',
                  '19.00',
                  'assets/images/fachadamuseoferro.jpg',
                  'Uno de los museos que pertenecen a la Secretaría de Cultura de México. Se fundó en el año de 1988, en un espacio histórico, donde operaron las antiguas estaciones del Ferrocarril Mexicano y el Mexicano del Sur. Este museo conserva y exhibe valiosas colecciones del patrimonio ferroviario del país, de distintas épocas, entre las que destacan locomotoras, coches de carga y carros de pasajeros; además, ofrece a sus visitantes exposiciones, visitas guiadas dramatizadas, presentaciones artísticas y de libros, talleres y conversatorios, entre otras actividades culturales.',
                ),
              ],
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

  Widget _buildMuseumCard(
      BuildContext context,
      int index,
      String title,
      String description,
      String price,
      String imageUrl,
      String extendedDescription) {
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
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'MyCustomFont'),
                        ),
                        const SizedBox(height: 4),
                        Text(description,
                            maxLines: 2, overflow: TextOverflow.ellipsis),
                        const SizedBox(height: 8),
                        Text('\$$price',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'MyCustomFont',
                            )),
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
                style:
                    TextStyle(color: Colors.white, fontFamily: 'MyCustomFont'),
              ),
            ),
          ),
          _buildMenuButton(
            context,
            icon: Icons.home,
            label: "Inici",
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
