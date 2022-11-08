import 'package:flutter/material.dart';
import 'package:celula_app/services/auth_service.dart';
import 'package:celula_app/ui/input_decorations.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      body: CustomScrollView(slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.grey[100], borderRadius: const BorderRadius.only(topRight: Radius.circular(200))),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/logoCefeg.png', width: 150, height: 150),
                      const SizedBox(height: 30),
                      const _LoginForm(),
                    ],
                  ),
                ),
              )),
        )
      ]),
    );
  }
}

class _LoginForm extends StatefulWidget {
  const _LoginForm({Key? key}) : super(key: key);

  @override
  State<_LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<_LoginForm> {
  final authService = AuthService();
  final GlobalKey<FormState> _formKey = GlobalKey();

  String nombre = '';
  String usuario = '';
  String clave = '';
  bool _isValidatingToken = true;
  bool _isLoading = false;

  bool isValidForm() {
    return _formKey.currentState?.validate() ?? false;
  }

  void validateToken() async {
    final isValidToken = await authService.validateToken();
    if (isValidToken) {
      Navigator.popAndPushNamed(context, 'home');
    }
    setState(() {
      _isValidatingToken = false;
    });
  }

  @override
  initState() {
    validateToken();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _isValidatingToken
        ? const _ValidateToken()
        : Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: [
                TextFormField(
                  autocorrect: false,
                  decoration: InputDecorations.authInputDecoration(labelText: 'Usuario', prefixIcon: Icons.person),
                  onChanged: (value) => usuario = value,
                  validator: (value) {
                    if (value != null && value.length >= 6) {
                      return null;
                    }
                    return 'El usuario debe de ser de mas de 5 caracteres';
                  },
                ),
                const SizedBox(height: 15),
                TextFormField(
                  autocorrect: false,
                  obscureText: true,
                  keyboardType: TextInputType.text,
                  decoration: InputDecorations.authInputDecoration(
                    labelText: 'Clave',
                    prefixIcon: Icons.lock_outlined,
                  ),
                  onChanged: (value) => clave = value,
                  validator: (value) {
                    if (value != null && value.length >= 6) {
                      return null;
                    }
                    return 'La contraseña debe tener mas de 5 caracteres';
                  },
                ),
                const SizedBox(height: 15),
                MaterialButton(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  disabledColor: Colors.grey,
                  color: Colors.blue[900],
                  onPressed: _isLoading
                      ? null
                      : () async {
                          if (!isValidForm()) return;

                          FocusScope.of(context).unfocus();
                          _isLoading = true;

                          final isValidLogin = await authService.login(usuario, clave);

                          if (isValidLogin) {
                            Navigator.popAndPushNamed(context, 'home');
                          }

                          _isLoading = false;
                        },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                    child: Text(
                      _isLoading ? 'Espere...' : 'Ingresar',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}

class _ValidateToken extends StatelessWidget {
  const _ValidateToken({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        CircularProgressIndicator(),
        SizedBox(height: 30),
        Text('Validando Sesión'),
      ],
    );
  }
}
