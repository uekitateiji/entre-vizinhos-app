import 'dart:async';
import 'package:flutter/material.dart';
import '../../../../shared/widgets/widgets.dart';
import '../login/login_page.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
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

  int currentIndex = 0;
  double progress = 0.0;
  Timer? timer;
  bool isPaused = false;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    timer?.cancel();
    timer = Timer.periodic(const Duration(milliseconds: 100), (t) {
      if (!mounted || isPaused) return;
      setState(() {
        progress += 0.02;
        if (progress >= 1.0) {
          progress = 0.0;
          currentIndex = (currentIndex + 1) % slides.length;
        }
      });
    });
  }

  void pauseTimer() {
    setState(() {
      isPaused = true;
      timer?.cancel();
    });
  }

  void resumeTimer() {
    setState(() {
      isPaused = false;
      startTimer();
    });
  }

  void nextSlide() {
    setState(() {
      progress = 0.0;
      currentIndex = (currentIndex + 1) % slides.length;
    });
  }

  void previousSlide() {
    setState(() {
      progress = 0.0;
      currentIndex = currentIndex == 0 ? slides.length - 1 : currentIndex - 1;
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Color _getProgressColor(double progress) {
    return Color.lerp(Theme.of(context).colorScheme.primary,
            Theme.of(context).colorScheme.primary, progress) ??
        Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    final slide = slides[currentIndex];

    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTapUp: (details) {
          final screenWidth = MediaQuery.of(context).size.width;
          if (details.localPosition.dx > screenWidth / 2) {
            nextSlide();
          } else {
            previousSlide();
          }
        },
        onLongPress: pauseTimer,
        onLongPressUp: resumeTimer,
        child: Stack(
          children: [
            AnimatedSwitcher(
              duration: const Duration(seconds: 1),
              child: Image.asset(
                slide['image']!,
                key: ValueKey(slide['id']),
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            SafeArea(
              child: Column(
                children: [
                  _buildProgressIndicator(),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 32),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          slide['title']!,
                          style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          slide['subtitle']!,
                          style: const TextStyle(
                              fontSize: 16, color: Colors.white70),
                        ),
                        const SizedBox(height: 68),

                        /// **Botão "Vamos lá!" - AGORA FUNCIONANDO CORRETAMENTE**
                        Center(
                          child: CustomButton(
                            text: "Vamos lá!",
                            onPressed: () {
                              /// Navegação correta para a tela de login
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginPage()),
                              );
                            },
                            backgroundColor:
                                Theme.of(context).colorScheme.primary,
                          ),
                        ),

                        const SizedBox(height: 32),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressIndicator() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: List.generate(slides.length, (index) {
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Stack(
                children: [
                  Container(
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 100),
                    height: 4,
                    width: index == currentIndex
                        ? progress *
                            MediaQuery.of(context).size.width /
                            slides.length
                        : 0,
                    decoration: BoxDecoration(
                      color: index == currentIndex
                          ? _getProgressColor(progress)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
