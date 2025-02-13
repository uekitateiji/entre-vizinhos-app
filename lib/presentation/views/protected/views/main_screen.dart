import 'package:flutter/material.dart';
import 'package:entre_vizinhos_app/presentation/shared/widgets/custom_app_bar/custom_app_bar.dart';
import '../views/home/home_page.dart';
import '../views/products_page/products_page.dart';
import '../views/advertise_page/advertise_page.dart';
import '../views/services_page/services_page.dart';
import '../views/menu_page/menu_page.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomePage(),
    const ProductsPage(),
    const AdvertisePage(),
    const ServicesPage(),
    const MenuPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titleTop: "Condomínio",
        titleBottom: "Hype Living - Augusta",
        actions: [
          IconButton(
            icon: const Icon(Icons.message, color: Colors.black),
            onPressed: () {
              // TODO: Navegar para a tela de mensagens
            },
          ),
        ],
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: _buildBottomNavigationBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _onItemTapped(2), // Vai para a página de anúncios
        backgroundColor: Colors.white,
        shape: const CircleBorder(),
        child: const Icon(Icons.add, color: Colors.black),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  /// Bottom Navigation Bar atualizado
  Widget _buildBottomNavigationBar() {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 8.0,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(Icons.home, "Início", 0),
            _buildNavItem(Icons.shopping_bag, "Produtos", 1),
            const SizedBox(width: 48), // Espaço para botão flutuante
            _buildNavItem(Icons.build, "Serviços", 3),
            _buildNavItem(Icons.menu, "Menu", 4),
          ],
        ),
      ),
    );
  }

  /// Item do Bottom Navigation Bar com texto descritivo
  Widget _buildNavItem(IconData icon, String label, int index) {
    final isSelected = _selectedIndex == index;

    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon,
              size: 24,
              color: isSelected
                  ? Theme.of(context).colorScheme.primary
                  : Colors.grey),
          const SizedBox(height: 2),
          Text(label,
              style: TextStyle(
                  fontSize: 11,
                  color: isSelected
                      ? Theme.of(context).colorScheme.primary
                      : Colors.grey)),
        ],
      ),
    );
  }
}
