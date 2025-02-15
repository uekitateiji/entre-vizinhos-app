import 'package:flutter/material.dart';
import '../services/banner_service.dart';

class BannerProvider with ChangeNotifier {
  List<dynamic> _banners = [];

  List<dynamic> get banners => _banners;

  Future<void> loadBanners() async {
    try {
      _banners = await BannerService.fetchBanners();
      notifyListeners(); // Atualiza os widgets que usam esse provider
    } catch (e) {
      print('Erro ao carregar banners: $e');
    }
  }
}
