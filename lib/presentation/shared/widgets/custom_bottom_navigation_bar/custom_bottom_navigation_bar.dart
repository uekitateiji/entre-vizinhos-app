import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const CustomBottomNavigationBar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 8.0,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(context, Icons.home, "Início", 0),
            _buildNavItem(context, Icons.shopping_bag, "Produtos", 1),
            const SizedBox(width: 48), // Espaço para botão flutuante
            _buildNavItem(context, Icons.build, "Serviços", 3),
            _buildNavItem(context, Icons.person, "Perfil", 4),
          ],
        ),
      ),
    );
  }

  /// Constrói cada item do menu sem alterar o layout original
  Widget _buildNavItem(BuildContext context, IconData icon, String label, int index) {
    final isSelected = selectedIndex == index;
    final color = isSelected ? Theme.of(context).colorScheme.primary : Colors.grey;

    return GestureDetector(
      onTap: () => onItemTapped(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 24, color: color),
          const SizedBox(height: 2),
          Text(label, style: TextStyle(fontSize: 11, color: color)),
        ],
      ),
    );
  }
}
