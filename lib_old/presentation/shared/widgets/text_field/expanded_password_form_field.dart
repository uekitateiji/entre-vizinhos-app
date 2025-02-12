import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ExpandedPasswordFormField extends StatefulWidget {
  final String label;
  final String? errorMessage;
  final bool error;
  final TextEditingController controller;
  final FocusNode focusNode;
  final bool showIcon;

  const ExpandedPasswordFormField({
    super.key,
    required this.label,
    this.errorMessage,
    required this.error,
    required this.controller,
    required this.focusNode,
    this.showIcon = false, // Ícone visível por padrão
  });

  @override
  State<ExpandedPasswordFormField> createState() =>
      _ExpandedPasswordFormFieldState();
}

class _ExpandedPasswordFormFieldState extends State<ExpandedPasswordFormField> {
  bool _isObscured = true; // Alternar visibilidade da senha

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, // Alinhamento correto
      children: [
        TextField(
          controller: widget.controller,
          focusNode: widget.focusNode,
          obscureText: _isObscured,
          keyboardType: TextInputType.number, // Somente números
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly, // Apenas números
            LengthLimitingTextInputFormatter(6), // Máximo de 6 caracteres
          ],
          onChanged: (value) {
            if (value.length > 6) {
              widget.controller.text = value.substring(0, 6);
              widget.controller.selection = TextSelection.collapsed(
                  offset: widget.controller.text.length);
            }
            setState(() {}); // Atualiza a tela ao digitar
          },
          decoration: InputDecoration(
            hintText: widget.label,
            hintStyle: const TextStyle(
              fontSize: 14,
              color: Colors.black54,
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: widget.error ? Colors.red : Colors.grey,
              ),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: widget.error
                    ? Colors.red
                    : Theme.of(context).colorScheme.primary,
                width: 2,
              ),
            ),
            suffixIcon: widget.showIcon
                ? Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade400,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: Icon(
                          _isObscured
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          setState(() {
                            _isObscured = !_isObscured;
                          });
                        },
                      ),
                    ),
                  )
                : null,
          ),
        ),
        // 🔹 Contador no canto inferior direito
        Padding(
          padding: const EdgeInsets.only(top: 4, right: 8),
          child: Align(
            alignment: Alignment.centerRight,
            child: Text(
              "${widget.controller.text.length}/6",
              style: TextStyle(
                fontSize: 12,
                color: widget.error ? Colors.red : Colors.grey.shade600,
              ),
            ),
          ),
        ),
        if (widget.errorMessage != null && widget.error)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              widget.errorMessage!,
              style: const TextStyle(
                color: Colors.red,
                fontSize: 12,
              ),
            ),
          ),
      ],
    );
  }
}
