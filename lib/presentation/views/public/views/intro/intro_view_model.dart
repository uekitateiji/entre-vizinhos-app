import 'dart:async';
import 'package:flutter/material.dart';
import '../../../../../services/banner_service.dart';

class IntroViewModel extends ChangeNotifier {
  List<Map<String, String>> _slides = [];
  bool _isLoading = true;
  bool _hasError = false;
  int _currentIndex = 0;
  double _progress = 0.0;
  Timer? _timer;
  bool _isPaused = false;

  /// 🔹 **Getters para acesso seguro**
  List<Map<String, String>> get slides => _slides;
  int get currentIndex => _currentIndex;
  double get progress => _progress;
  bool get isPaused => _isPaused;
  bool get isLoading => _isLoading;
  bool get hasError => _hasError;
  Map<String, String>? get currentSlide =>
      _slides.isNotEmpty ? _slides[_currentIndex] : null;

  /// 🔹 **Construtor: Carrega os banners ao iniciar**
  IntroViewModel() {
    _fetchBanners();
  }

  /// 🔹 **Busca os banners da API e atualiza a lista**
  Future<void> _fetchBanners() async {
    try {
      final response = await BannerService.fetchBanners();
      if (response.isNotEmpty) {
        _slides = _mapBanners(response);
        _isLoading = false;
        _hasError = false;
        _startSlideTimer();
      } else {
        _setErrorState();
      }
    } catch (e) {
      print('Erro ao buscar banners: $e');
      _setErrorState();
    }
    notifyListeners();
  }

  /// 🔹 **Converte os dados da API para o formato esperado**
  List<Map<String, String>> _mapBanners(List<dynamic> response) {
    return response.map<Map<String, String>>((banner) {
      return {
        'id': banner['id'].toString(),
        'image': banner['image_url'] ?? '',
        'title': banner['title'] ?? '',
        'subtitle': banner['description'] ?? '',
      };
    }).toList();
  }

  /// 🔹 **Define estado de erro e para carregamento**
  void _setErrorState() {
    _hasError = true;
    _isLoading = false;
  }

  /// 🔹 **Inicia o timer para trocar os slides automaticamente**
  void _startSlideTimer() {
    _cancelTimer();
    _timer = Timer.periodic(const Duration(milliseconds: 100), (t) {
      if (_isPaused || _slides.isEmpty) return;
      _updateSlideProgress();
    });
  }

  /// 🔹 **Atualiza o progresso do slide**
  void _updateSlideProgress() {
    _progress += 0.02;
    if (_progress >= 1.0) {
      _progress = 0.0;
      _nextSlide();
    }
    notifyListeners();
  }

  /// 🔹 **Avança para o próximo slide**
  void _nextSlide() {
    _currentIndex = (_currentIndex + 1) % _slides.length;
  }

  /// 🔹 **Cancela o timer**
  void _cancelTimer() {
    _timer?.cancel();
  }

  /// 🔹 **Pausa o timer**
  void pauseTimer() {
    _isPaused = true;
    _cancelTimer();
    notifyListeners();
  }

  /// 🔹 **Retoma o timer**
  void resumeTimer() {
    _isPaused = false;
    _startSlideTimer();
    notifyListeners();
  }

  /// 🔹 **Avança para o próximo slide (manual)**
  void nextSlide() {
    if (_slides.isNotEmpty) {
      _progress = 0.0;
      _nextSlide();
      notifyListeners();
    }
  }

  /// 🔹 **Volta para o slide anterior**
  void previousSlide() {
    _progress = 0.0;
    if (_slides.isNotEmpty && _currentIndex > 0) {
      _currentIndex -= 1;
      notifyListeners();
    }
  }

  /// 🔹 **Define a cor da barra de progresso**
  Color getProgressColor(BuildContext context) {
    return Color.lerp(
          Theme.of(context).colorScheme.primary,
          Theme.of(context).colorScheme.primary,
          _progress,
        ) ??
        Colors.white;
  }

  /// 🔹 **Cancela o timer ao destruir o ViewModel**
  @override
  void dispose() {
    _cancelTimer();
    super.dispose();
  }
}
