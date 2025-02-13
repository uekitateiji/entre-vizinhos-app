import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../shared/widgets/widgets.dart';
import '../../../auth/login_page.dart';
import 'intro_view_model.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => IntroViewModel(),
      child: const _IntroPageContent(),
    );
  }
}

class _IntroPageContent extends StatelessWidget {
  const _IntroPageContent();

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<IntroViewModel>(context);
    final slide = viewModel.currentSlide;

    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTapUp: (details) => _handleSlideNavigation(details, context, viewModel),
        onLongPress: viewModel.pauseTimer,
        onLongPressUp: viewModel.resumeTimer,
        child: Stack(
          children: [
            _buildBackgroundImage(slide),
            SafeArea(
              child: Column(
                children: [
                  _buildProgressIndicator(context, viewModel),
                  const Spacer(),
                  _buildSlideContent(context, slide),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 🔹 **Navegação entre slides**
  void _handleSlideNavigation(TapUpDetails details, BuildContext context, IntroViewModel viewModel) {
    final screenWidth = MediaQuery.of(context).size.width;
    details.localPosition.dx > screenWidth / 2 ? viewModel.nextSlide() : viewModel.previousSlide();
  }

  /// 🔹 **Imagem de fundo animada**
  Widget _buildBackgroundImage(Map<String, String> slide) {
    return AnimatedSwitcher(
      duration: const Duration(seconds: 1),
      child: Image.asset(
        slide['image'] ?? '',
        key: ValueKey(slide['id']),
        width: double.infinity,
        height: double.infinity,
        fit: BoxFit.cover,
      ),
    );
  }

  /// 🔹 **Indicador de progresso dos slides**
  Widget _buildProgressIndicator(BuildContext context, IntroViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: List.generate(viewModel.slides.length, (index) {
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Stack(
                children: [
                  _buildProgressBackground(),
                  _buildProgressBar(context, viewModel, index),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  /// 🔹 **Fundo do indicador de progresso**
  Widget _buildProgressBackground() {
    return Container(
      height: 4,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.3),
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }

  /// 🔹 **Barra de progresso animada**
  Widget _buildProgressBar(BuildContext context, IntroViewModel viewModel, int index) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 100),
      height: 4,
      width: index == viewModel.currentIndex
          ? viewModel.progress * MediaQuery.of(context).size.width / viewModel.slides.length
          : 0,
      decoration: BoxDecoration(
        color: index == viewModel.currentIndex
            ? Theme.of(context).colorScheme.primary
            : Colors.transparent,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }

  /// 🔹 **Conteúdo do slide (Texto + Botão)**
  Widget _buildSlideContent(BuildContext context, Map<String, String> slide) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSlideText(slide),
          const SizedBox(height: 68),
          _buildActionButton(context),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  /// 🔹 **Texto do slide**
  Widget _buildSlideText(Map<String, String> slide) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          slide['title'] ?? '',
          style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        const SizedBox(height: 16),
        Text(
          slide['subtitle'] ?? '',
          style: const TextStyle(fontSize: 16, color: Colors.white70),
        ),
      ],
    );
  }

  /// 🔹 **Botão "Vamos lá!"**
  Widget _buildActionButton(BuildContext context) {
    return Center(
      child: CustomButton(
        text: "Vamos lá!",
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const LoginPage())),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}
