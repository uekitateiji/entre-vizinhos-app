import 'package:flutter/material.dart';
import 'presentation/views/public/views/intro/intro_page.dart';

void main() {
  runApp(const EntreVizinhosApp());
}

class EntreVizinhosApp extends StatelessWidget {
  const EntreVizinhosApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Entre Vizinhos",
      theme: ThemeData(
        fontFamily: 'PlusJakartaSans',
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xff456EFE),
          primary: const Color(0xff456EFE),
          secondary: const Color(0xff27AE5F),
          tertiary: const Color(0xffF2C94C),
        ),
      ),
      home: const IntroPage(),
    );
  }
}
