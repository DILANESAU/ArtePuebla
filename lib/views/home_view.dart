import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16.0),
              _buildHeader(),
              const SizedBox(height: 20.0),
              _buildImageCarousel(),
              const SizedBox(height: 24.0),
              _buildTitleSection(),
              const SizedBox(height: 16.0),
              _buildFeaturedList(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Arte Puebla",
            style: TextStyle(
              fontSize: 28.0,
              fontWeight: FontWeight.bold,
              color: Color(0xFF660033), // Color vino
            ),
          ),
          IconButton(
            icon: const Icon(Icons.search, color: Color(0xFF660033)),
            onPressed: () {
              // Acción de búsqueda
            },
          ),
        ],
      ),
    );
  }

  Widget _buildImageCarousel() {
    final List<String> imageUrls = [
    'https://www.ciudadespatrimonio.mx/wp-content/uploads/2018/04/museoamparo.jpg',
    'https://museospuebla.puebla.gob.mx/media/k2/attachments/16_Arquitectura.jpg',
    'https://www.mexicoescultura.com/galerias/espacios/principal/museo_regional_de_cholula.jpg'
    ];

    return SizedBox(
      height: 200,
      child: PageView.builder(
        itemCount: imageUrls.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: Image.network(
                imageUrls[index],
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTitleSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            "Explora los museos",
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Color(0xFF660033), // Color vino
            ),
          ),
          SizedBox(height: 4.0),
          Text(
            "Descubre lugares llenos de historia y arte.",
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturedList() {
    final List<Map<String, String>> featuredMuseums = [
      {"title": "Museo Amparo", "subtitle": "Arte prehispánico y moderno"},
      {"title": "Museo Evolución", "subtitle": "Historia natural y fósiles"},
      {"title": "Museo Ferrocarril", "subtitle": "Historia del transporte"},
    ];

    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        itemCount: featuredMuseums.length,
        itemBuilder: (context, index) {
          final museum = featuredMuseums[index];
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            elevation: 4,
            margin: const EdgeInsets.only(bottom: 16.0),
            child: ListTile(
              contentPadding: const EdgeInsets.all(16.0),
              title: Text(
                museum["title"]!,
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF660033), // Color vino
                ),
              ),
              subtitle: Text(
                museum["subtitle"]!,
                style: const TextStyle(color: Colors.grey),
              ),
              trailing: const Icon(Icons.chevron_right, color: Colors.grey),
              onTap: () {
                // Navegación al detalle del museo
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      selectedItemColor: const Color(0xFF660033), // Color vino
      unselectedItemColor: Colors.grey,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Inicio',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.museum),
          label: 'Museos',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Perfil',
        ),
      ],
      onTap: (index) {
        // Control de navegación
      },
    );
  }
}
