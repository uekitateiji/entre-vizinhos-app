import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../shared/widgets/widgets.dart';
import 'reset_password_view_model.dart';

class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ResetPasswordViewModel(),
      child: const _ResetPasswordPageContent(),
    );
  }
}

class _ResetPasswordPageContent extends StatelessWidget {
  const _ResetPasswordPageContent();

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ResetPasswordViewModel>(context);

    return Scaffold(
      appBar: _buildAppBar(context),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Redefinir senha",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 4),
                const Text(
                  "Digite seu e-mail para redefinir a senha:",
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildEmailField(viewModel),
            const SizedBox(height: 32),
            _buildResetButton(viewModel, context),
          ],
        ),
      ),
    );
  }

  /// 🔹 **Campo de E-mail**
  Widget _buildEmailField(ResetPasswordViewModel viewModel) {
    return TextField(
      controller: viewModel.emailController,
      decoration: InputDecoration(
        hintText: "Email",
        filled: true,
        fillColor: Colors.grey[200],
        border: _buildInputBorder(),
        prefixIcon: const Icon(Icons.email, color: Colors.grey),
        errorText: viewModel.emailError, // Exibe erro caso exista
      ),
    );
  }

  /// 🔹 **Botão de redefinir senha**
  Widget _buildResetButton(
      ResetPasswordViewModel viewModel, BuildContext context) {
    return CustomButton(
      text: "Redefinir Senha",
      onPressed: () => viewModel.resetPassword(context),
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
