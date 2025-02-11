import 'package:flutter/material.dart';
import '../login/login_page.dart';
import '../../../../shared/widgets/widgets.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Poppins',
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xff2D9BDB),
            primary: const Color(0xff2D9BDB),
            secondary: const Color(0xff27AE5F),
            tertiary: const Color(0xffF2C94C),
            surfaceBright: const Color(0xffF2F2F2),
            surfaceContainerHigh: const Color(0xff333333)),
      ),
      debugShowCheckedModeBanner: false,
      title: "Entre Vizinhos",
      home: const WelcomeScreen(),
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/background-left.png",
              fit: BoxFit.cover,
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Spacer(flex: 4),
                  Text(
                    "Bem-vindo, Vizinho!",
                    style: TextStyle(
                      height: 1,
                      fontSize: screenWidth * 0.1,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "Encontre produtos e serviços\ndentro do seu condomínio",
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                  const Spacer(flex: 3),
                  Column(
                    children: [
                      CustomButton(
                        text: "Criar conta",
                        onPressed: () {},
                        backgroundColor: Theme.of(context).colorScheme.primary,
                      ),
                      const SizedBox(height: 16),
                      Align(
                        alignment: Alignment.center,
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginPage()),
                            );
                          },
                          child: const Text(
                            "Já tenho conta!",
                            style:
                                TextStyle(fontSize: 14, color: Colors.black54),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// **Widget reutilizável para botões**
