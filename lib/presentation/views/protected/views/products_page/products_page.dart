import 'package:entre_vizinhos_app/presentation/views/protected/views/products_page/widgets/product_card.dart';
import 'package:flutter/material.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  _ProductsPageState createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  /// Lista de produtos dinâmica
  final List<Map<String, String>> products = [
    {
      "imageUrl": "assets/images/lancer-ralliart.png",
      "title": "Mitsubishi - Lancer Ralliart 2012 / Teto Solar",
      "price": "R\$93.000,00",
      "date": "28 Jan 2021",
    },
    {
      "imageUrl": "assets/images/pc-gamer.png",
      "title": "PC Gamer - RTX 4090",
      "price": "R\$12.000,00",
      "date": "10 Fev 2021",
    },
    {
      "imageUrl": "assets/images/sofa.png",
      "title": "Sofá 2 lugares",
      "price": "R\$500,00",
      "date": "20 Mar 2021",
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Produtos Disponíveis",
              style: TextStyle(fontSize: 22, color: Colors.black),
            ),
            const SizedBox(height: 16),
            _buildSearchBar(),
            const SizedBox(height: 16),
            _buildTabBar(),
            const SizedBox(height: 8),
            Expanded(child: _buildTabContent()),
          ],
        ),
      ),
    );
  }

  /// Barra de pesquisa
  Widget _buildSearchBar() {
    return TextField(
      decoration: InputDecoration(
        hintText: "Buscar produtos",
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

  /// TabBar para Produtos e Serviços
  Widget _buildTabBar() {
    return TabBar(
      controller: _tabController,
      indicatorColor: Theme.of(context).colorScheme.primary,
      labelColor: Colors.black,
      unselectedLabelColor: Colors.grey,
      indicatorWeight: 2,
      tabs: const [
        Tab(text: "Anúncios"),
        Tab(text: "Precisam de..."),
      ],
    );
  }

  /// Conteúdo das Tabs
  Widget _buildTabContent() {
    return TabBarView(
      controller: _tabController,
      children: [
        _buildProductList(), // Produtos Novos
        _buildProductList(), // Produtos Usados (por enquanto a mesma lista)
      ],
    );
  }

  /// Lista de produtos dinâmica
  Widget _buildProductList() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: GridView.builder(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(vertical: 8),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.75,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return ProductCard(
            imageUrl: product["imageUrl"]!,
            title: product["title"]!,
            price: product["price"]!,
            date: product["date"]!,
          );
        },
      ),
    );
  }
}
