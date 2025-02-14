import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../shared/widgets/widgets.dart';
import 'login_view_model.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LoginViewModel(),
      child: const _LoginPageContent(),
    );
  }
}

class _LoginPageContent extends StatelessWidget {
  const _LoginPageContent();

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<LoginViewModel>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(context),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeaderText(),
            const SizedBox(height: 32),
            _buildEmailField(viewModel),
            const SizedBox(height: 16),
            _buildPasswordField(viewModel),
            const SizedBox(height: 32),
            CustomButton(
              text: "Acessar",
              onPressed: () => viewModel.login(context),
              backgroundColor: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 16),
            CustomButton(
              text: "Redefinir senha",
              onPressed: () => viewModel.navigateToResetPassword(context),
              backgroundColor: Colors.grey,
            ),
            const SizedBox(height: 32),
            Center(
              child: _buildSignupText(viewModel, context),
            ),
          ],
        ),
      ),
    );
  }

  /// 🔹 **Cabeçalho da página**
  Widget _buildHeaderText() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Fazer Login",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 4),
        Text(
          "Bem vindo, vizin!",
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  /// 🔹 **Campo de E-mail**
  Widget _buildEmailField(LoginViewModel viewModel) {
    return TextField(
      controller: viewModel.emailController,
      decoration: InputDecoration(
        hintText: "Email",
        filled: true,
        fillColor: Colors.grey[200],
        border: _buildInputBorder(),
        prefixIcon: const Icon(Icons.email, color: Colors.grey),
        errorText: viewModel.emailError, // Exibe erro abaixo do campo
      ),
    );
  }

  /// 🔹 **Campo de Senha**
  Widget _buildPasswordField(LoginViewModel viewModel) {
    return TextField(
      controller: viewModel.passwordController,
      obscureText: !viewModel.isPasswordVisible,
      decoration: InputDecoration(
        hintText: "Senha",
        filled: true,
        fillColor: Colors.grey[200],
        border: _buildInputBorder(),
        prefixIcon: const Icon(Icons.lock, color: Colors.grey),
        errorText: viewModel.passwordError, // Exibe erro abaixo do campo
      ),
    );
  }

  /// 🔹 **Texto "Não possui conta? Crie agora!"**
  Widget _buildSignupText(LoginViewModel viewModel, context) {
    return GestureDetector(
      onTap: () {
        viewModel.navigateToCreateAccount(context);
      },
      child: Text(
        "Não possui conta? Crie agora!",
        style: TextStyle(fontSize: 14, color: Colors.grey[700]),
      ),
    );
  }

  /// 🔹 **Borda padrão dos campos de entrada**
  OutlineInputBorder _buildInputBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide.none,
    );
  }

  /// 🔹 **AppBar personalizada**
  PreferredSizeWidget _buildAppBar(context) {
    return CustomAppBar(
      icon: Icons.arrow_back,
      onIconPressed: () {
        Navigator.pop(context);
      },
    );
  }
}
