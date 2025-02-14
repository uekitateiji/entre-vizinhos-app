import 'package:flutter/material.dart';

class ResetPasswordViewModel extends ChangeNotifier {
  final TextEditingController emailController = TextEditingController();
  String? emailError;

  /// 🔹 **Validação do e-mail**
  bool _validateEmail(String email) {
    if (email.isEmpty) {
      emailError = "Email obrigatório!";
      return false;
    }
    final regex = RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
    if (!regex.hasMatch(email)) {
      emailError = "Email inválido!";
      return false;
    }
    emailError = null;
    return true;
  }

  /// 🔹 **Função de redefinir senha**
  void resetPassword(BuildContext context) {
    final isEmailValid = _validateEmail(emailController.text);

    if (isEmailValid) {
      // 🔹 Simula envio de redefinição de senha (substitua por integração real)
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Email para redefinição enviado!")),
      );
      Navigator.pop(context); // Fecha a tela após sucesso
    }

    notifyListeners(); // Atualiza UI caso tenha erro
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }
}
