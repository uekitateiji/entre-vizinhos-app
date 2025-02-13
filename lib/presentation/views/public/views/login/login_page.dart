import 'package:entre_vizinhos_app/presentation/views/protected/views/home/home_page.dart';
import 'package:flutter/material.dart';
import '../../../../shared/widgets/widgets.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            /// Espaço superior
            const Expanded(flex: 2, child: SizedBox()),

            /// Campos de entrada
            TextField(
              decoration: InputDecoration(
                hintText: "E-mail",
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              obscureText: !isPasswordVisible,
              decoration: InputDecoration(
                hintText: "Senha",
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      isPasswordVisible = !isPasswordVisible;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              "Esqueceu a senha?",
              style: TextStyle(
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 48),
            SizedBox(
              width: double.infinity,
              child: CustomButton(
                text: "Acessar",
                onPressed: () {
                  /// Navegação correta para a tela de login
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HomePage()),
                  );
                },
                backgroundColor: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(height: 32),
            Row(
              children: [
                const Expanded(child: Divider(thickness: 1)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text("ou",
                      style: TextStyle(
                        color: Colors.grey[600],
                      )),
                ),
                const Expanded(child: Divider(thickness: 1)),
              ],
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  side: const BorderSide(
                    color: Colors.grey,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/icons/icon-google.png", height: 24),
                    const SizedBox(width: 10),
                    const Text("Log in with Google",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        )),
                  ],
                ),
              ),
            ),

            /// Espaço entre os botões e o texto final
            const Expanded(flex: 1, child: SizedBox()),

            /// Texto final "Não possui conta? Crie agora!"
            GestureDetector(
              onTap: () {
                // Adicione a ação para ir para a tela de cadastro, se necessário
              },
              child: Text(
                "Não possui conta? Crie agora!",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[700],
                ),
              ),
            ),

            /// Espaço inferior
            const SizedBox(height: 68),
          ],
        ),
      ),
    );
  }
}
