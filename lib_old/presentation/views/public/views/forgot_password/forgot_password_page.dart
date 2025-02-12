import 'package:flutter/material.dart';
import '../../../../shared/widgets/widgets.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController _novaSenhaController = TextEditingController();
  final TextEditingController _confirmarSenhaController = TextEditingController();
  final FocusNode _novaSenhaFocusNode = FocusNode();
  final FocusNode _confirmarSenhaFocusNode = FocusNode();

  bool _novaSenhaValida = true;
  bool _confirmarSenhaValida = true;
  bool _isObscured = true;

  void _validarSenha() {
    setState(() {
      _novaSenhaValida = _novaSenhaController.text.length == 6;
      _confirmarSenhaValida = _novaSenhaController.text == _confirmarSenhaController.text;
    });
  }

  void _togglePasswordVisibility() {
    setState(() {
      _isObscured = !_isObscured;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        icon: Icons.arrow_back,
        onIconPressed: () {
          Navigator.pop(context);
        },
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/background-right.png",
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
                  const Text(
                    "Redefinição de senha",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "Digite uma nova senha e confirme para continuar.",
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                  const Spacer(flex: 3),

                  // **Campo Nova Senha**
                  ExpandedPasswordFormField(
                    label: "Nova Senha",
                    controller: _novaSenhaController,
                    error: !_novaSenhaValida,
                    errorMessage: "A senha deve ter 6 caracteres",
                    focusNode: _novaSenhaFocusNode,
                    showIcon: true,
                  ),
                  const SizedBox(height: 16),

                  // **Campo Confirmar Senha**
                  ExpandedPasswordFormField(
                    label: "Confirme a nova senha",
                    controller: _confirmarSenhaController,
                    error: !_confirmarSenhaValida,
                    errorMessage: "Os campos devem ser iguais",
                    focusNode: _confirmarSenhaFocusNode,
                  ),
                  const Spacer(flex: 3),

                  // **Botões Fixos na Parte Inferior**
                  Column(
                    children: [
                      CustomButton(
                        text: "Avançar",
                        onPressed: _validarSenha,
                        backgroundColor: Theme.of(context).colorScheme.primary,
                      ),
                      const SizedBox(height: 16),
                      Align(
                        alignment: Alignment.center,
                        child: TextButton(
                          onPressed: () {},
                          child: const Text(
                            "Cancelar",
                            style: TextStyle(color: Colors.black54, fontSize: 16),
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

  @override
  void dispose() {
    _novaSenhaController.dispose();
    _confirmarSenhaController.dispose();
    _novaSenhaFocusNode.dispose();
    _confirmarSenhaFocusNode.dispose();
    super.dispose();
  }
}
