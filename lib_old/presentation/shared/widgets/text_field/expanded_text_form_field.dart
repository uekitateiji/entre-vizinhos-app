import 'package:flutter/material.dart';

class ExpandedTextFormField extends StatefulWidget {
  final String label;
  final VoidCallback onActionButton;
  final String? errorMessage;
  final bool error;
  final TextEditingController controller;
  final FocusNode focusNode;
  final TextInputType keyboardType;
  final bool isValid;

  const ExpandedTextFormField({
    super.key,
    required this.label,
    required this.onActionButton,
    this.errorMessage,
    required this.error,
    required this.controller,
    required this.focusNode,
    this.keyboardType = TextInputType.text,
    required this.isValid,
  });

  @override
  State<ExpandedTextFormField> createState() => _ExpandedTextFormFieldState();
}

class _ExpandedTextFormFieldState extends State<ExpandedTextFormField>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(-0.3, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    if (widget.isValid) {
      _controller.forward();
    }
  }

  @override
  void didUpdateWidget(covariant ExpandedTextFormField oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.isValid && !oldWidget.isValid) {
      _controller.forward();
    } else if (!widget.isValid && oldWidget.isValid) {
      _controller.reverse();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Mensagem de erro acima do campo
        if (widget.error && widget.errorMessage != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 6.0),
            child: Text(
              widget.errorMessage!,
              style: const TextStyle(
                color: Colors.red,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

        TextField(
          controller: widget.controller,
          focusNode: widget.focusNode,
          keyboardType: widget.keyboardType,
          decoration: InputDecoration(
            hintText: widget.label,
            hintStyle: const TextStyle(
              fontSize: 14,
              color: Colors.black38,
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

prefixIconConstraints: BoxConstraints(
              minWidth: widget.isValid ? 40 : 0,
              minHeight: 0,
            ),
            prefixIcon: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return FadeTransition(
                  opacity: _fadeAnimation,
                  child: SlideTransition(
                    position: _slideAnimation,
                    child: child,
                  ),
                );
              },
              child: widget.isValid
                  ? Icon(
                      Icons.check,
                      color: Theme.of(context).colorScheme.secondary,
                      key: const ValueKey("checkIcon"),
                    )
                  : null,
            ),

            // Ícone avançar
            suffixIcon: Padding(
              padding: const EdgeInsets.only(right: 8.0, bottom: 8.0),
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: widget.error
                      ? Colors.grey
                      : Theme.of(context).colorScheme.primary,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: const Icon(Icons.arrow_forward, color: Colors.white),
                  onPressed: widget.onActionButton,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
