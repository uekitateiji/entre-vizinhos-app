import 'package:flutter/material.dart';
import '../protected/views/main_screen.dart';
import '../public/views/reset_password/reset_password_page.dart';
import '../public/views/create_account_page/create_account_page.dart';
import 'package:flutter/foundation.dart';
class LoginViewModel extends ChangeNotifier {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isPasswordVisible = false;
  String? emailError;
  String? passwordError;

  /// Valida o e-mail digitado
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

  /// Valida a senha digitada
  bool _validatePassword(String password) {
    if (password.isEmpty) {
      passwordError = "Senha obrigatória!";
      return false;
    }
    if (password.length < 8) {
      passwordError = "Senha inválida!";
      return false;
    }
    passwordError = null;
    return true;
  }

  /// Executa a validação e navega se estiver tudo certo
  void login(BuildContext context) {
    final isEmailValid = _validateEmail(emailController.text);
    final isPasswordValid = _validatePassword(passwordController.text);

    if (isEmailValid && isPasswordValid || kDebugMode) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const MainScreen()),
      );
    }

    notifyListeners(); // Atualiza a tela para exibir os erros se existirem
  }

  /// Navega para a tela de redefinição de senha
  void navigateToResetPassword(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ResetPasswordPage()),
    );
  }

  /// Alterna a visibilidade da senha
  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    notifyListeners();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  /// 🔹 **Navega para Criar Conta**
  void navigateToCreateAccount(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CreateAccountPage()),
    );
  }
}
