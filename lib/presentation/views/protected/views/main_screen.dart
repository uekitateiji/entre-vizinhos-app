import 'package:flutter/material.dart';
import '../views/home/home_page.dart';
import '../views/products_page/products_page.dart';
import '../views/advertise_page/advertise_page.dart';
import '../views/services_page/services_page.dart';
import '../views/menu_page/menu_page.dart';
import '../../../shared/widgets/widgets.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
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
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _screens[_selectedIndex],
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _onItemTapped(2),
        backgroundColor: Colors.white,
        shape: const CircleBorder(),
        child: const Icon(Icons.add, color: Colors.grey),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  /// AppBar personalizado
  PreferredSizeWidget _buildAppBar() {
    return CustomAppBar(
      titleTop: "Condomínio",
      titleBottom: "Hype Living - Augusta",
      actions: [
        IconButton(
          icon: const Icon(Icons.message, color: Colors.black),
          onPressed: () {},
        ),
      ],
    );
  }
}
