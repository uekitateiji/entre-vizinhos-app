import 'package:flutter/material.dart';
import '../login/login_page.dart';
import '../../../../shared/components/custom_button.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Poppins'),
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
              "assets/background-boas-vindas.png",
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
                        backgroundColor: Colors.green,
                      ),
                      const SizedBox(height: 8),
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
