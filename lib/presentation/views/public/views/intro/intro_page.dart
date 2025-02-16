import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../shared/widgets/widgets.dart';
import '../../../auth/login_page.dart';
import '../../../../../providers/banner_provider.dart';
import 'intro_view_model.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => IntroViewModel()),
        ChangeNotifierProvider(
          create: (_) => BannerProvider()..loadBanners(),
        ),
      ],
      child: const _IntroPageContent(),
    );
  }
}

class _IntroPageContent extends StatelessWidget {
  const _IntroPageContent();

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<IntroViewModel>();
    final bannerProvider = context.watch<BannerProvider>();

    if (bannerProvider.banners.isEmpty || viewModel.currentIndex >= bannerProvider.banners.length) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final slide = bannerProvider.banners[viewModel.currentIndex];

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
                  _buildProgressIndicator(context, viewModel, bannerProvider.banners),
                  const SizedBox(height: 32),
                  _buildTitle(), // Adicionando o título "VIZIN"
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

  /// 🔹 **Título "VIZIN" posicionado no topo**
  Widget _buildTitle() {
    return const Padding(
      padding: EdgeInsets.only(top: 16), // Ajuste para alinhar corretamente
      child: Text(
        "VIZIN",
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          letterSpacing: 1.5,
        ),
      ),
    );
  }

  void _handleSlideNavigation(TapUpDetails details, BuildContext context, IntroViewModel viewModel) {
    final screenWidth = MediaQuery.of(context).size.width;
    details.localPosition.dx > screenWidth / 2 ? viewModel.nextSlide() : viewModel.previousSlide();
  }

  Widget _buildBackgroundImage(Map<String, dynamic> slide) {
    return AnimatedSwitcher(
      duration: const Duration(seconds: 1),
      transitionBuilder: (Widget child, Animation<double> animation) {
        return FadeTransition(opacity: animation, child: child);
      },
      child: Image.network(
        slide['image_url'] ?? '',
        key: ValueKey(slide['id']),
        width: double.infinity,
        height: double.infinity,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => const Center(
          child: Text("Erro ao carregar imagem", style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }

  Widget _buildProgressIndicator(BuildContext context, IntroViewModel viewModel, List banners) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: List.generate(
          banners.length,
          (index) => Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Stack(
                children: [
                  _buildProgressBackground(),
                  _buildProgressBar(context, viewModel, index, banners.length),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProgressBackground() {
    return Container(
      height: 4,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.3),
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }

  Widget _buildProgressBar(BuildContext context, IntroViewModel viewModel, int index, int totalSlides) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 100),
      height: 4,
      width: index == viewModel.currentIndex
          ? viewModel.progress * MediaQuery.of(context).size.width / totalSlides
          : 0,
      decoration: BoxDecoration(
        color: index == viewModel.currentIndex
            ? Theme.of(context).colorScheme.primary
            : Colors.transparent,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }

  Widget _buildSlideContent(BuildContext context, Map<String, dynamic> slide) {
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

  Widget _buildSlideText(Map<String, dynamic> slide) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          (slide['title'] ?? '').replaceAll(r'\n', '\n'),
          style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        const SizedBox(height: 16),
        Text(
          slide['description'] ?? '',
          style: const TextStyle(fontSize: 16, color: Colors.white70),
        ),
      ],
    );
  }

  Widget _buildActionButton(BuildContext context) {
    return Center(
      child: CustomButton(
        text: "Vamos lá!",
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const LoginPage()),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}
