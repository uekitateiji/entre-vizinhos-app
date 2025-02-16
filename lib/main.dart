import 'package:entre_vizinhos_app/presentation/views/public/views/intro/intro_view_model.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'presentation/views/public/views/intro/intro_page.dart';
import 'providers/banner_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Inicializa o Firebase

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => BannerProvider()), // 🔹 Provider do Banner
        ChangeNotifierProvider(
            create: (context) =>
                IntroViewModel()), // 🔹 Provider do IntroViewModel
      ],
      child: const EntreVizinhosApp(),
    ),
  );
}

class EntreVizinhosApp extends StatelessWidget {
  const EntreVizinhosApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Entre Vizinhos",
      theme: _buildTheme(),
      home: const IntroPage(),
    );
  }

  /// 🔹 **Configuração do Tema**
  ThemeData _buildTheme() {
    return ThemeData(
      fontFamily: 'PlusJakartaSans',
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xff456EFE), // Azul primário
        primary: const Color(0xff456EFE),
        secondary: const Color(0xffFFA133), // Laranja secundário
        surface: Colors.white, // Cor de fundo dos cards
        error: const Color(0xffFF4D4D), // Vermelho para erros
      ),
      disabledColor:
          const Color(0xffDADADA), // Cinza para elementos desativados
      scaffoldBackgroundColor: const Color(0xffFFFFFF),
      useMaterial3: true,
    );
  }
}
