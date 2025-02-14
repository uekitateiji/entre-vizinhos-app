import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../shared/widgets/widgets.dart';
import 'create_account_view_model.dart';

class CreateAccountPage extends StatelessWidget {
  const CreateAccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CreateAccountViewModel(),
      child: const _CreateAccountPageContent(),
    );
  }
}

class _CreateAccountPageContent extends StatelessWidget {
  const _CreateAccountPageContent();

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<CreateAccountViewModel>(context);

    return Scaffold(
      appBar: _buildAppBar(context),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeaderText(),
            const SizedBox(height: 32),
            _buildNameField(viewModel),
            const SizedBox(height: 16),
            _buildEmailField(viewModel),
            const SizedBox(height: 16),
            _buildPasswordField(viewModel),
            const SizedBox(height: 16),
            _buildConfirmPasswordField(viewModel),
            const SizedBox(height: 32),
            _buildCreateAccountButton(viewModel, context),
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
          "Criar Conta",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          "Preencha os campos abaixo para criar sua conta.",
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }

  /// 🔹 **Campo de Nome**
  Widget _buildNameField(CreateAccountViewModel viewModel) {
    return TextField(
      controller: viewModel.nameController,
      decoration: InputDecoration(
        hintText: "Nome Completo",
        filled: true,
        fillColor: Colors.grey[200],
        border: _buildInputBorder(),
        prefixIcon: const Icon(Icons.person, color: Colors.grey),
        errorText: viewModel.nameError,
      ),
    );
  }

  /// 🔹 **Campo de E-mail**
  Widget _buildEmailField(CreateAccountViewModel viewModel) {
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
  Widget _buildPasswordField(CreateAccountViewModel viewModel) {
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
            viewModel.isPasswordVisible ? Icons.visibility : Icons.visibility_off,
            color: Colors.grey,
          ),
          onPressed: viewModel.togglePasswordVisibility,
        ),
      ),
    );
  }

  /// 🔹 **Campo de Confirmação de Senha**
  Widget _buildConfirmPasswordField(CreateAccountViewModel viewModel) {
    return TextField(
      controller: viewModel.confirmPasswordController,
      obscureText: !viewModel.isConfirmPasswordVisible,
      decoration: InputDecoration(
        hintText: "Confirme a Senha",
        filled: true,
        fillColor: Colors.grey[200],
        border: _buildInputBorder(),
        prefixIcon: const Icon(Icons.lock, color: Colors.grey),
        errorText: viewModel.confirmPasswordError,
        suffixIcon: IconButton(
          icon: Icon(
            viewModel.isConfirmPasswordVisible ? Icons.visibility : Icons.visibility_off,
            color: Colors.grey,
          ),
          onPressed: viewModel.toggleConfirmPasswordVisibility,
        ),
      ),
    );
  }

  /// 🔹 **Botão de Criar Conta**
  Widget _buildCreateAccountButton(CreateAccountViewModel viewModel, BuildContext context) {
    return CustomButton(
      text: "Criar Conta",
      onPressed: () => viewModel.createAccount(context),
      backgroundColor: Theme.of(context).colorScheme.primary,
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
