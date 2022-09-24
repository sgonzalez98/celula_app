import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:celula_app/providers/login_form_provider.dart';
import 'package:celula_app/services/auth_service.dart';
import 'package:celula_app/services/notifications_service.dart';
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
                  color: Colors.grey[100],
                  borderRadius:
                      const BorderRadius.only(topRight: Radius.circular(200))),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/logoCefeg.png',
                          width: 150, height: 150),
                      const SizedBox(height: 30),
                      ChangeNotifierProvider(
                          create: (_) => LoginFormProvider(),
                          child: const _LoginForm())
                    ],
                  ),
                ),
              )),
        )
      ]),
    );
  }
}

class _LoginForm extends StatelessWidget {
  const _LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loginForm = Provider.of<LoginFormProvider>(context);

    return Form(
      key: loginForm.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          TextFormField(
            autocorrect: false,
            decoration: InputDecorations.authInputDecoration(
                labelText: 'Usuario', prefixIcon: Icons.person),
            onChanged: (value) => loginForm.usuario = value,
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
            onChanged: (value) => loginForm.clave = value,
            validator: (value) {
              if (value != null && value.length >= 2) {
                return null;
              }
              return 'La contraseña debe tener mas de 6 caracteres';
            },
          ),
          const SizedBox(height: 15),
          MaterialButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            disabledColor: Colors.grey,
            color: Colors.blue[900],
            onPressed: loginForm.isLoading
                ? null
                : () async {
                    if (!loginForm.isValidForm()) return;

                    FocusScope.of(context).unfocus();
                    loginForm.isLoading = true;

                    final authService =
                        Provider.of<AuthService>(context, listen: false);

                    final String? errorMessage = await authService.login(
                        loginForm.usuario, loginForm.clave);
                    if (errorMessage == null) {
                      Navigator.popAndPushNamed(context, 'home');
                    } else {
                      NotificationsService.showSnackBar(errorMessage);
                      loginForm.isLoading = false;
                    }
                  },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
              child: Text(
                loginForm.isLoading ? 'Espere...' : 'Ingresar',
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
          const SizedBox(height: 15),
          TextButton(
              onPressed: () {
                Navigator.pushNamed(context, 'register');
              },
              child: const Text('Registrarse')),
        ],
      ),
    );
  }
}
