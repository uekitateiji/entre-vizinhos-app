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
            if (viewModel.errorMessage?.isNotEmpty == true)
              _buildErrorMessage(viewModel), // ✅ Correção aplicada
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
    return _buildTextField(
      controller: viewModel.nameController,
      hintText: "Nome Completo",
      icon: Icons.person,
      errorText: viewModel.nameError,
    );
  }

  /// 🔹 **Campo de E-mail**
  Widget _buildEmailField(CreateAccountViewModel viewModel) {
    return _buildTextField(
      controller: viewModel.emailController,
      hintText: "Email",
      icon: Icons.email,
      errorText: viewModel.emailError,
    );
  }

  /// 🔹 **Campo de Senha**
  Widget _buildPasswordField(CreateAccountViewModel viewModel) {
    return _buildTextField(
      controller: viewModel.passwordController,
      hintText: "Senha",
      icon: Icons.lock,
      errorText: viewModel.passwordError,
      obscureText: !viewModel.isPasswordVisible,
      suffixIcon: IconButton(
        icon: Icon(
          viewModel.isPasswordVisible ? Icons.visibility : Icons.visibility_off,
          color: Colors.grey,
        ),
        onPressed: viewModel.togglePasswordVisibility,
      ),
    );
  }

  /// 🔹 **Campo de Confirmação de Senha**
  Widget _buildConfirmPasswordField(CreateAccountViewModel viewModel) {
    return _buildTextField(
      controller: viewModel.confirmPasswordController,
      hintText: "Confirme a Senha",
      icon: Icons.check,
      errorText: viewModel.confirmPasswordError,
      obscureText: !viewModel.isConfirmPasswordVisible,
      suffixIcon: IconButton(
        icon: Icon(
          viewModel.isConfirmPasswordVisible
              ? Icons.visibility
              : Icons.visibility_off,
          color: Colors.grey,
        ),
        onPressed: viewModel.toggleConfirmPasswordVisibility,
      ),
    );
  }

  /// 🔹 **Campo de Texto Reutilizável**
  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    String? errorText,
    bool obscureText = false,
    Widget? suffixIcon,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        fillColor: Colors.grey[200],
        border: _buildInputBorder(),
        prefixIcon: Icon(icon, color: Colors.grey),
        errorText: errorText,
        suffixIcon: suffixIcon,
      ),
    );
  }

  /// 🔹 **Botão de Criar Conta**
  Widget _buildCreateAccountButton(
      CreateAccountViewModel viewModel, BuildContext context) {
    return CustomButton(
      text: viewModel.isLoading ? "Criando..." : "Criar Conta",
      onPressed: viewModel.isLoading
          ? () {}
          : () => _handleCreateAccount(viewModel, context),
      backgroundColor: Theme.of(context).colorScheme.primary,
    );
  }

  /// 🔹 **Mensagem de erro**
  Widget _buildErrorMessage(CreateAccountViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Text(
        viewModel.errorMessage ?? "Erro desconhecido", // ✅ Correção aplicada
        style: const TextStyle(color: Colors.red),
      ),
    );
  }

  /// 🔹 **Valida e chama a API**
  void _handleCreateAccount(
      CreateAccountViewModel viewModel, BuildContext context) async {
    final success = await viewModel.createAccount(context);

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Conta criada com sucesso!")),
      );
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(viewModel.errorMessage?.isNotEmpty == true
              ? viewModel.errorMessage!
              : "Erro ao criar conta"), // ✅ Correção aplicada
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
      onIconPressed: () {
        Navigator.pop(context);
      },
    );
  }
}
