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
            create: (_) => BannerProvider()
              ..loadBanners()), // 🔹 Carrega os banners automaticamente
      ],
      child: const _IntroPageContent(),
    );
  }
}

class _IntroPageContent extends StatelessWidget {
  const _IntroPageContent();

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<IntroViewModel>(context);
    final banners = Provider.of<BannerProvider>(context).banners;
    final slide = banners.isNotEmpty
        ? banners[viewModel.currentIndex]
        : viewModel.currentSlide;

    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTapUp: (details) =>
            _handleSlideNavigation(details, context, viewModel),
        onLongPress: viewModel.pauseTimer,
        onLongPressUp: viewModel.resumeTimer,
        child: Stack(
          children: [
            _buildBackgroundImage(slide),
            SafeArea(
              child: Column(
                children: [
                  _buildProgressIndicator(context, viewModel, banners),
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
  void _handleSlideNavigation(
      TapUpDetails details, BuildContext context, IntroViewModel viewModel) {
    final screenWidth = MediaQuery.of(context).size.width;
    details.localPosition.dx > screenWidth / 2
        ? viewModel.nextSlide()
        : viewModel.previousSlide();
  }

  /// 🔹 **Imagem de fundo animada corrigida com UniqueKey()**
  Widget _buildBackgroundImage(Map<String, dynamic> slide) {
    return AnimatedSwitcher(
      duration: const Duration(seconds: 1),
      transitionBuilder: (Widget child, Animation<double> animation) {
        return FadeTransition(opacity: animation, child: child);
      },
      child: Stack(
        children: [
          Positioned.fill(
            child: Container(
              color: Colors.black, // 🔹 Fundo para evitar o efeito esmaecido
            ),
          ),
          Positioned.fill(
            child: FadeInImage.assetNetwork(
              key:
                  UniqueKey(), // 🔹 Garante que o AnimatedSwitcher não reaproveite chaves erradas
              placeholder:
                  'assets/loading_placeholder.png', // 🔹 Use uma imagem local como loading
              image: slide['image_url'] ?? '',
              fit: BoxFit.cover,
              fadeInDuration:
                  const Duration(milliseconds: 500), // 🔹 Animação suave
              fadeOutDuration: const Duration(milliseconds: 500),
              imageErrorBuilder: (context, error, stackTrace) =>
                  const Center(child: Text("Erro ao carregar imagem")),
            ),
          ),
        ],
      ),
    );
  }

  /// 🔹 **Indicador de progresso dos slides**
  Widget _buildProgressIndicator(
      BuildContext context, IntroViewModel viewModel, List banners) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: List.generate(
            banners.isNotEmpty ? banners.length : viewModel.slides.length,
            (index) {
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Stack(
                children: [
                  _buildProgressBackground(),
                  _buildProgressBar(
                      context,
                      viewModel,
                      index,
                      banners.isNotEmpty
                          ? banners.length
                          : viewModel.slides.length),
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
  Widget _buildProgressBar(BuildContext context, IntroViewModel viewModel,
      int index, int totalSlides) {
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

  /// 🔹 **Conteúdo do slide (Texto + Botão)**
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

  /// 🔹 **Texto do slide**
  Widget _buildSlideText(Map<String, dynamic> slide) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          (slide['title'] ?? '')
              .replaceAll(r'\n', '\n'), // 🔹 Força a conversão
          style: const TextStyle(
              fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        const SizedBox(height: 16),
        Text(
          slide['description'] ?? '',
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
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (_) => const LoginPage())),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}
