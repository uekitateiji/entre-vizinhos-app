import 'dart:async';
import 'package:flutter/material.dart';

class IntroViewModel extends ChangeNotifier {
  final List<Map<String, String>> slides = [
    {
      'id': '1',
      'image': 'assets/banner-1.png',
      'title': 'O marketplace\nexclusivo para o seu\ncondomínio!',
      'subtitle':
          'Compre, venda e contrate serviços de forma\nrápida e segura, sem sair de casa.'
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
      'subtitle':
          'Venda o que não usa mais e encontre produtos incríveis dentro do seu condomínio.'
    },
  ];

  int _currentIndex = 0;
  double _progress = 0.0;
  Timer? _timer;
  bool _isPaused = false;

  int get currentIndex => _currentIndex;
  double get progress => _progress;
  bool get isPaused => _isPaused;
  Map<String, String> get currentSlide => slides[_currentIndex];

  IntroViewModel() {
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(milliseconds: 100), (t) {
      if (_isPaused) return;
      _updateProgress();
    });
  }

  void _updateProgress() {
    _progress += 0.02;
    if (_progress >= 1.0) {
      _progress = 0.0;
      _currentIndex = (_currentIndex + 1) % slides.length;
    }
    notifyListeners();
  }

  void pauseTimer() {
    _isPaused = true;
    _timer?.cancel();
    notifyListeners();
  }

  void resumeTimer() {
    _isPaused = false;
    _startTimer();
    notifyListeners();
  }

  void nextSlide() {
    _progress = 0.0;
    _currentIndex = (_currentIndex + 1) % slides.length;
    notifyListeners();
  }

  void previousSlide() {
    _progress = 0.0;
    if (_currentIndex > 0) {
      _currentIndex -= 1;
    }
  }

  Color getProgressColor(BuildContext context) {
    return Color.lerp(
          Theme.of(context).colorScheme.primary,
          Theme.of(context).colorScheme.primary,
          _progress,
        ) ??
        Colors.white;
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
