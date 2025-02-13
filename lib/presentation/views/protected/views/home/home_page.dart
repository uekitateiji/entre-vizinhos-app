import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.chat, color: Colors.black),
            onPressed: () {
              // Ação para abrir mensagens
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Condomínio",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.grey),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    "Hype Living - Augusta",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  const SizedBox(height: 32),
                  _buildSearchBar(),
                  const SizedBox(height: 16),
                  _buildTabBar(),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Expanded(child: _buildTabContent()),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.white,
        shape: const CircleBorder(),
        child: const Icon(Icons.add, color: Colors.black),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  /// Barra de pesquisa
  Widget _buildSearchBar() {
    return TextField(
      decoration: InputDecoration(
        hintText: "Buscar",
        prefixIcon: const Icon(Icons.search, color: Colors.grey),
        filled: true,
        fillColor: Colors.grey[100],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  /// TabBar para Produtos e Serviços com novos nomes
  Widget _buildTabBar() {
    return TabBar(
      controller: _tabController,
      indicatorColor: Theme.of(context).colorScheme.primary,
      labelColor: Colors.black,
      unselectedLabelColor: Colors.grey,
      indicatorWeight: 2,
      tabs: const [
        Tab(text: "Anúncios Disponíveis"),  // Novo nome
        Tab(text: "O que os vizinhos procuram"),  // Novo nome
      ],
    );
  }

  /// Conteúdo das tabs
  Widget _buildTabContent() {
    return TabBarView(
      controller: _tabController,
      children: [
        _buildProductList(),
        const Center(child: Text("Nenhum pedido disponível")),
      ],
    );
  }

  /// Lista de produtos agora em Grid
  Widget _buildProductList() {
    return Padding(
      padding: EdgeInsets.only(bottom: 16),
      child: GridView.builder(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.75,
        ),
        itemCount: 2,
        itemBuilder: (context, index) {
          return _buildProductCard(
            imageUrl: "assets/banner-1.png",
            title: "Mitsubishi - Lancer Ralliart 2012 / Teto Solar",
            price: "R\$93.000,00",
            date: "28 Jan 2021",
          );
        },
      ),
    );
  }

  /// Card de produto atualizado conforme o print
  Widget _buildProductCard({
    required String imageUrl,
    required String title,
    required String price,
    required String date,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            spreadRadius: 1,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.asset(
              imageUrl,
              height: 180,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      price,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      date,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
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
            _buildNavItem(Icons.shopping_bag, "Produtos", 1),  // Alterado para Produtos
            const SizedBox(width: 48),
            _buildNavItem(Icons.build, "Serviços", 2),  // Alterado para Serviços
            _buildNavItem(Icons.person, "Perfil", 3),
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
          Icon(icon, size: 24, color: isSelected ? Theme.of(context).colorScheme.primary : Colors.grey),
          const SizedBox(height: 2),
          Text(label, style: TextStyle(fontSize: 11, color: isSelected ? Theme.of(context).colorScheme.primary : Colors.grey)),
        ],
      ),
    );
  }
}
