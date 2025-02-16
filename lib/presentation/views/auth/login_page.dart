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
            _buildLoginButton(viewModel, context),
            const SizedBox(height: 16),
            _buildResetPasswordButton(viewModel, context),
            const SizedBox(height: 32),
            _buildSignupText(viewModel, context),
            if (viewModel.errorMessage?.isNotEmpty == true)
              _buildErrorMessage(viewModel),
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
          "Fazer login",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 4),
        Text(
          "Bem-vindo, vizin!",
          style: TextStyle(fontSize: 16),
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
        errorText: viewModel.emailError,
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
        errorText: viewModel.passwordError,
        suffixIcon: IconButton(
          icon: Icon(
            viewModel.isPasswordVisible
                ? Icons.visibility
                : Icons.visibility_off,
            color: Colors.grey,
          ),
          onPressed: viewModel.togglePasswordVisibility,
        ),
      ),
    );
  }

  /// 🔹 **Botão de Login**
  Widget _buildLoginButton(LoginViewModel viewModel, BuildContext context) {
    return CustomButton(
      text: viewModel.isLoading ? "Entrando..." : "Acessar",
      onPressed:
          viewModel.isLoading ? () {} : () => _handleLogin(viewModel, context),
      backgroundColor: Theme.of(context).colorScheme.primary,
    );
  }

  /// 🔹 **Botão de Redefinir Senha**
  Widget _buildResetPasswordButton(
      LoginViewModel viewModel, BuildContext context) {
    return CustomButton(
      text: "Redefinir senha",
      onPressed: () => viewModel.navigateToResetPassword(context),
      backgroundColor: Colors.grey,
    );
  }

  /// 🔹 **Texto "Não possui conta? Crie agora!"**
  Widget _buildSignupText(LoginViewModel viewModel, BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () => viewModel.navigateToCreateAccount(context),
        child: Text(
          "Não possui conta? Crie agora!",
          style: TextStyle(fontSize: 14, color: Colors.grey[700]),
        ),
      ),
    );
  }

  /// 🔹 **Mensagem de Erro**
  Widget _buildErrorMessage(LoginViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Center(
        child: Text(
          viewModel.errorMessage!,
          style: const TextStyle(color: Colors.red),
        ),
      ),
    );
  }

  /// 🔹 **Executa o Login**
  void _handleLogin(LoginViewModel viewModel, BuildContext context) async {
    final success = await viewModel.login(context);

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Login realizado com sucesso!")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(viewModel.errorMessage?.isNotEmpty == true
              ? viewModel.errorMessage!
              : "Erro ao realizar login"),
        ),
      );
    }
  }

  /// 🔹 **Borda padrão dos campos de entrada**
  OutlineInputBorder _buildInputBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide.none,
    );
  }

  /// 🔹 **AppBar personalizada**
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      icon: Icons.arrow_back,
      titleTop: 'VIZIN',
      onIconPressed: () {
        Navigator.pop(context);
      },
    );
  }
}
