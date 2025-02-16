import 'package:flutter/material.dart';
import '../../../../../services/user_service.dart';
import '../protected/views/main_screen.dart';
import '../public/views/reset_password/reset_password_page.dart';
import '../public/views/create_account_page/create_account_page.dart';

class LoginViewModel extends ChangeNotifier {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isPasswordVisible = false;
  bool isLoading = false;
  String? emailError;
  String? passwordError;
  String? errorMessage;

  /// 🔹 **Valida e-mail**
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

  /// 🔹 **Valida senha**
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

  /// 🔹 **Autenticar usuário**
  Future<bool> login(BuildContext context) async {
    final isEmailValid = _validateEmail(emailController.text);
    final isPasswordValid = _validatePassword(passwordController.text);

    if (!isEmailValid || !isPasswordValid) {
      notifyListeners(); // Exibir erros nos campos
      return false;
    }

    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final response = await UserService.loginUser(
        emailController.text,
        passwordController.text,
      );

      if (response.containsKey('token')) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Login realizado com sucesso!")),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MainScreen()), // Redireciona para a home
        );
        return true;
      } else {
        errorMessage = "E-mail ou senha incorretos.";
      }
    } catch (e) {
      errorMessage = "Erro ao fazer login: ${e.toString()}";
    }

    isLoading = false;
    notifyListeners();
    return false;
  }

  /// 🔹 **Navega para redefinição de senha**
  void navigateToResetPassword(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ResetPasswordPage()),
    );
  }

  /// 🔹 **Navega para Criar Conta**
  void navigateToCreateAccount(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CreateAccountPage()),
    );
  }

  /// 🔹 **Alterna visibilidade da senha**
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
}
