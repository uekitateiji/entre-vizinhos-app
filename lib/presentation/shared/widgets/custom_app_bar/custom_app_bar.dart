import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? titleTop; // Ex: "Condomínio"
  final String? titleBottom; // Ex: "Hype Living - Augusta"
  final IconData? icon;
  final VoidCallback? onIconPressed;
  final List<Widget>? actions;

  const CustomAppBar({
    super.key,
    this.titleTop,
    this.titleBottom,
    this.icon,
    this.onIconPressed,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      automaticallyImplyLeading: false,
      leading: _buildLeadingIcon(),
      title: _buildTitle(context),
      centerTitle: true,
      actions: actions,
    );
  }

  /// Ícone no canto esquerdo, opcional
  Widget? _buildLeadingIcon() {
    if (icon == null) return null;
    return IconButton(
      icon: Icon(icon, color: Colors.black),
      onPressed: onIconPressed ?? () => Navigator.pop,
    );
  }

  /// Título centralizado com um ou dois textos opcionais
  Widget _buildTitle(BuildContext context) {
    if (titleTop == null && titleBottom == null) return const SizedBox();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (titleTop != null)
          Text(
            titleTop!,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
        if (titleBottom != null) ...[
          const SizedBox(height: 2),
          Text(
            titleBottom!,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(70);
}
