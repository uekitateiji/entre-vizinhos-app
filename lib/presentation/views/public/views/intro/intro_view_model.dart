import 'dart:async';
import 'package:flutter/material.dart';

class IntroViewModel extends ChangeNotifier {
  final List<Map<String, String>> _slides = [
    {
      'id': '1',
      'image': 'assets/banner-1.png',
      'title': 'O marketplace\nexclusivo para o seu\ncondomínio!',
      'subtitle': 'Compre, venda e contrate serviços de forma\nrápida e segura, sem sair de casa.'
    },
    {
      'id': '2',
      'image': 'assets/banner-2.png',
      'title': 'Negociações seguras entre vizinhos!',
      'subtitle': 'Seu marketplace local, com mais confiança e transparência.'
    },
    {
      'id': '3',
      'image': 'assets/banner-3.png',
      'title': 'Anuncie e compre sem sair de casa!',
      'subtitle': 'Venda o que não usa mais e encontre produtos incríveis dentro do seu condomínio.'
    },
  ];

  bool _isLoading = false;
  int _currentIndex = 0;
  double _progress = 0.0;
  Timer? _timer;
  bool _isPaused = false;

  List<Map<String, String>> get slides => _slides;
  int get currentIndex => _currentIndex;
  double get progress => _progress;
  bool get isPaused => _isPaused;
  bool get isLoading => _isLoading;
  Map<String, String> get currentSlide => _slides[_currentIndex];

  IntroViewModel() {
    _startSlideTimer();
  }

  void _startSlideTimer() {
    _timer = Timer.periodic(const Duration(milliseconds: 100), (t) {
      if (_isPaused) return;
      _progress += 0.02;
      if (_progress >= 1.0) {
        _progress = 0.0;
        nextSlide();
      }
      notifyListeners();
    });
  }

  void nextSlide() {
    _progress = 0.0;
    _currentIndex = (_currentIndex + 1) % _slides.length;
    notifyListeners();
  }

  void previousSlide() {
    _progress = 0.0;
    if (_currentIndex > 0) _currentIndex--;
    notifyListeners();
  }

  void pauseTimer() => _isPaused = true;
  void resumeTimer() => _isPaused = false;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
