import 'package:flutter/material.dart';

class CreateAccountViewModel extends ChangeNotifier {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;
  
  String? nameError;
  String? emailError;
  String? passwordError;
  String? confirmPasswordError;

  /// 🔹 **Valida Nome**
  bool _validateName(String name) {
    if (name.isEmpty) {
      nameError = "Nome obrigatório!";
      return false;
    }
    nameError = null;
    return true;
  }

  /// 🔹 **Valida E-mail**
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

  /// 🔹 **Valida Senha**
  bool _validatePassword(String password) {
    if (password.isEmpty) {
      passwordError = "Senha obrigatória!";
      return false;
    }
    if (password.length < 8) {
      passwordError = "A senha deve ter pelo menos 8 caracteres!";
      return false;
    }
    passwordError = null;
    return true;
  }

  /// 🔹 **Valida Confirmação de Senha**
  bool _validateConfirmPassword(String password, String confirmPassword) {
    if (confirmPassword.isEmpty) {
      confirmPasswordError = "Confirme sua senha!";
      return false;
    }
    if (password != confirmPassword) {
      confirmPasswordError = "As senhas não coincidem!";
      return false;
    }
    confirmPasswordError = null;
    return true;
  }

  /// 🔹 **Criar Conta**
  void createAccount(BuildContext context) {
    final isNameValid = _validateName(nameController.text);
    final isEmailValid = _validateEmail(emailController.text);
    final isPasswordValid = _validatePassword(passwordController.text);
    final isConfirmPasswordValid = _validateConfirmPassword(passwordController.text, confirmPasswordController.text);

    if (isNameValid && isEmailValid && isPasswordValid && isConfirmPasswordValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Conta criada com sucesso!")),
      );
      Navigator.pop(context); // Retorna para a tela de login
    }

    notifyListeners();
  }

  /// 🔹 **Alterna visibilidade das senhas**
  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    notifyListeners();
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible = !isConfirmPasswordVisible;
    notifyListeners();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}
