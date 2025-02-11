import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../forgot_password/forgot_password_page.dart';
import '../../../../shared/widgets/widgets.dart';

class PasswordPage extends StatefulWidget {
  final String email;

  const PasswordPage({super.key, required this.email});

  @override
  State<PasswordPage> createState() => _PasswordPageState();
}

class _PasswordPageState extends State<PasswordPage>
    with SingleTickerProviderStateMixin {
  String _password = "";
  final String _correctPassword = "123456";
  bool _isPasswordValid = true;
  late AnimationController _shakeController;
  late Animation<double> _shakeAnimation;

  @override
  void initState() {
    super.initState();
    _shakeController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    )..addListener(() {
        setState(() {});
      });

    _shakeAnimation = Tween<double>(begin: 0, end: 8)
        .chain(CurveTween(curve: Curves.elasticIn))
        .animate(_shakeController);
  }

  void _onNumberPressed(String value) {
    if (_password.length < 6) {
      setState(() {
        _password += value;
      });

      if (_password.length == 6) {
        _validatePassword();
      }
    }
  }

  void _onDeletePressed() {
    if (_password.isNotEmpty) {
      setState(() {
        _password = _password.substring(0, _password.length - 1);
        _isPasswordValid = true;
      });
    }
  }

  void _validatePassword() {
    if (_password == _correctPassword) {
      _onPasswordValidated();
    } else {
      _triggerErrorFeedback();
    }
  }

  void _triggerErrorFeedback() async {
    setState(() {
      _isPasswordValid = false;
    });

    HapticFeedback.vibrate();

    _shakeController.forward(from: 0);

    await Future.delayed(const Duration(milliseconds: 300));

    setState(() {
      _password = "";
      _isPasswordValid = true;
    });
  }

  void _onPasswordValidated() {
    print("Senha correta! Proseguindo...");
  }

  @override
  void dispose() {
    _shakeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        icon: Icons.arrow_back,
        title: widget.email,
        onIconPressed: () {
          Navigator.pop(context, widget.email);
        },
      ),
      body: Stack(
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 70),
                  const Center(
                    child: Text(
                      "Oie, Teiji!",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 48),
                  Transform.translate(
                    offset:
                        Offset(_isPasswordValid ? 0 : _shakeAnimation.value, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(6, (index) {
                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 100),
                          curve: Curves.easeInOut,
                          margin: const EdgeInsets.symmetric(horizontal: 16),
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: index < _password.length
                                ? (_isPasswordValid ? Theme.of(context).colorScheme.primary : Colors.red)
                                : const Color(0xffD9D9D9),
                          ),
                        );
                      }),
                    ),
                  ),
                  const SizedBox(height: 32),
                  const Center(
                    child: Text(
                      "Digite sua senha",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          for (int i = 0; i < 3; i++)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(3, (j) {
                                int number = i * 3 + j + 1;
                                return _buildNumberButton(number.toString());
                              }),
                            ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(width: 112),
                              _buildNumberButton("0"),
                              _buildDeleteButton(),
                            ],
                          ),
                          const SizedBox(height: 32),
                          Center(
                            child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const ForgotPasswordPage(),
                                  ),
                                );
                              },
                              child: Text(
                                "Esqueceu a sua senha?",
                                style: TextStyle(
                                    fontSize: 16, color: Theme.of(context).colorScheme.surfaceContainerHigh),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNumberButton(String number) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: SizedBox(
        width: 80,
        height: 80,
        child: ElevatedButton(
          onPressed: () => _onNumberPressed(number),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xffD9D9D9),
            shape: const CircleBorder(),
            padding: EdgeInsets.zero,
          ),
          child: Text(
            number,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w400,
              color: Colors.black.withOpacity(0.5),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDeleteButton() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: SizedBox(
        width: 80,
        height: 80,
        child: ElevatedButton(
          onPressed: _onDeletePressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey.shade300,
            shape: const CircleBorder(),
            padding: EdgeInsets.zero,
          ),
          child: const Icon(
            Icons.backspace,
            color: Colors.black,
            size: 24,
          ),
        ),
      ),
    );
  }
}
