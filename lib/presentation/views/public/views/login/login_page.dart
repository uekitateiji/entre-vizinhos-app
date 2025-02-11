import 'package:flutter/material.dart';
import '../password/password_page.dart';
import '../../../../shared/components/custom_app_bar.dart';

class LoginPage extends StatefulWidget {
  final String? email;

  const LoginPage({super.key, this.email});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController _emailController;
  final FocusNode _emailFocusNode = FocusNode();
  bool _isEmailValid = true;
  String? _errorMessage;
  bool _hasStartedTyping = false;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(text: widget.email ?? "");

    // Aguarda a primeira renderização para focar no campo de e-mail
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        FocusScope.of(context).requestFocus(_emailFocusNode);
      }
    });

    // Monitora mudanças no texto para ativar a validação após o usuário começar a digitar
    _emailController.addListener(_onTextChanged);
  }

  bool _validateEmail(String email) {
    return RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
        .hasMatch(email);
  }

  void _onTextChanged() {
    String email = _emailController.text.trim();

    if (!_hasStartedTyping && email.isNotEmpty) {
      setState(() {
        _hasStartedTyping = true;
      });
    }

    if (_hasStartedTyping) {
      bool isValid = _validateEmail(email);
      setState(() {
        _isEmailValid = isValid;
        _errorMessage = isValid ? null : "Por favor, insira um e-mail válido!";
      });
    }
  }

  void _onEmailSubmit() async {
    String email = _emailController.text.trim();
    bool isValid = _validateEmail(email);

    setState(() {
      _isEmailValid = isValid;
      _errorMessage = isValid ? null : "Por favor, insira um e-mail válido!";
    });

    if (isValid) {
      FocusScope.of(context).unfocus();

      final returnedEmail = await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => PasswordPage(email: email)),
      );

      if (returnedEmail != null && returnedEmail is String) {
        setState(() {
          _emailController.text = returnedEmail;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      appBar: const CustomAppBar(
        icon: Icons.arrow_back,
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/background-acessar-conta.png",
              fit: BoxFit.cover,
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Positioned(
                          top: 100,
                          left: screenWidth * 0.06,
                          right: screenWidth * 0.06,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "Acesse\nsua conta!",
                                style: TextStyle(
                                  height: 1,
                                  fontSize: screenWidth * 0.12,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Poppins',
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 10),
                              const Row(
                                children: [
                                  Text(
                                    "Que bom te ver novamente! ",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'Poppins',
                                      color: Colors.black54,
                                    ),
                                  ),
                                  Icon(Icons.favorite, color: Colors.red, size: 18),
                                ],
                              ),
                            ],
                          ),
                        ),
                        AnimatedPositioned(
                          duration: const Duration(milliseconds: 200),
                          bottom: keyboardHeight > 0
                              ? keyboardHeight + 20
                              : screenHeight * 0.4,
                          left: screenWidth * 0.06,
                          right: screenWidth * 0.06,
                          child: Column(
                            children: [
                              TextField(
                                controller: _emailController,
                                focusNode: _emailFocusNode,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  hintText: "Digite o seu e-mail",
                                  hintStyle: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.black54,
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: _hasStartedTyping
                                          ? (_isEmailValid ? Colors.green : Colors.red)
                                          : Colors.grey,
                                    ),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: _hasStartedTyping
                                          ? (_isEmailValid ? Colors.green : Colors.red)
                                          : Colors.grey,
                                      width: 2,
                                    ),
                                  ),
                                  suffixIcon: Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: _hasStartedTyping
                                            ? (_isEmailValid ? Colors.green : Colors.grey)
                                            : Colors.grey,
                                        shape: BoxShape.circle,
                                      ),
                                      child: IconButton(
                                        icon: const Icon(Icons.arrow_forward, color: Colors.white),
                                        onPressed: _onEmailSubmit,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              if (_errorMessage != null && _hasStartedTyping)
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Text(
                                    _errorMessage!,
                                    style: const TextStyle(
                                      color: Colors.red,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
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

  @override
  void dispose() {
    _emailController.removeListener(_onTextChanged);
    _emailController.dispose();
    _emailFocusNode.dispose();
    super.dispose();
  }
}
