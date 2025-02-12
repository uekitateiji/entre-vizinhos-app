import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final IconData? icon;
  final String? title;
  final VoidCallback? onIconPressed;

  const CustomAppBar({
    super.key,
    this.icon,
    this.title,
    this.onIconPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent, // Deixa o fundo transparente
      elevation: 0, // Remove sombra
      automaticallyImplyLeading: false, // Evita adicionar um ícone padrão
      leading: icon != null
          ? IconButton(
              icon: Icon(icon, color: Colors.black),
              onPressed: onIconPressed ?? () => Navigator.pop(context),
            )
          : null, // Garante que não exiba um botão vazio se o ícone não for passado
      title: title != null
          ? Text(
              title!,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black54,
              ),
            )
          : null, // Evita erro se `title` for nulo

      centerTitle: true, // Mantém o título centralizado
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
