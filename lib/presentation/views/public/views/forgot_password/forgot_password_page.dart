import 'package:flutter/material.dart';
import '../../../../shared/components/custom_button.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  String _selectedMethod = 'SMS'; // Opção inicial

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          // Background verde no topo
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 200,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                ),
              ),
            ),
          ),

          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 20),

                // Avatar
                Container(
                  width: 90,
                  height: 90,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    border: Border.all(color: Colors.grey.shade300, width: 2),
                  ),
                ),

                const SizedBox(height: 20),

                // Título "Recuperar senha"
                const Text(
                  "Recuperar senha",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),

                const SizedBox(height: 10),

                // Texto "Como você gostaria de recuperar sua senha?"
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: Text(
                    "Como você gostaria de recuperar sua senha?",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Opções de seleção (SMS e Email)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.15),
                  child: Column(
                    children: [
                      _buildRecoveryOption("SMS"),
                      _buildRecoveryOption("Email"),
                    ],
                  ),
                ),

                const Spacer(),

                // Botão "Próximo"
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: CustomButton(
                    text: "Próximo",
                    onPressed: () {},
                    backgroundColor: Colors.green,
                  ),
                ),
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.center,
                  child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      "Cancelar",
                      style: TextStyle(fontSize: 14, color: Colors.black54),
                    ),
                  ),
                ),

                const SizedBox(height: 30),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Widget para criar opções de recuperação de senha
  Widget _buildRecoveryOption(String title) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(30),
      ),
      child: RadioListTile<String>(
        title: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: _selectedMethod == title ? Colors.blue : Colors.black54,
          ),
        ),
        value: title,
        groupValue: _selectedMethod,
        activeColor: Colors.blue,
        onChanged: (value) {
          setState(() {
            _selectedMethod = value!;
          });
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        tileColor: Colors.transparent,
        dense: true,
      ),
    );
  }
}
