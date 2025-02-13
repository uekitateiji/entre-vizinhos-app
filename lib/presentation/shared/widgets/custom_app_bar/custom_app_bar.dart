import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String titleTop; // Texto superior (ex: "Condomínio")
  final String titleBottom; // Texto inferior (ex: "Hype Living - Augusta")
  final IconData? icon;
  final VoidCallback? onIconPressed;
  final List<Widget>? actions; // Agora aceita múltiplas ações

  const CustomAppBar({
    super.key,
    required this.titleTop,
    required this.titleBottom,
    this.icon,
    this.onIconPressed,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white, // Fundo branco
      elevation: 0, // Remove sombra
      automaticallyImplyLeading: false, // Remove o botão padrão de voltar
      leading: icon != null
          ? IconButton(
              icon: Icon(icon, color: Colors.black),
              onPressed: onIconPressed ?? () => Navigator.pop(context),
            )
          : null, // Se não tiver ícone, não exibe nada

      title: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            titleTop,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            titleBottom,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
      ),

      centerTitle: true, // Centraliza os textos
      actions: actions, // Adiciona os botões na AppBar
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(70); // Ajuste na altura para suportar dois textos
}
