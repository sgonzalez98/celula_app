import 'package:celula_app/services/auth_service.dart';
import 'package:celula_app/services/notifications_service.dart';
import 'package:celula_app/ui/input_decorations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrate'),
      ),
      backgroundColor: Colors.grey[100],
      body: CustomScrollView(slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Image.asset('assets/logoCefeg.png', width: 130, height: 130),
                  const SizedBox(height: 30),
                  _RegisterForm(),
                ],
              ),
            ),
          ),
        )
      ]),
    );
  }
}

class _RegisterForm extends StatelessWidget {
  const _RegisterForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      // key: loginForm.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          TextFormField(
            autocorrect: false,
            decoration: InputDecorations.authInputDecoration(labelText: 'Nombre completo', prefixIcon: Icons.person),
            // onChanged: (value) => loginForm.nombre = value,
            validator: (value) {
              if (value != null && value.length >= 6) {
                return null;
              }
              return 'El nombre debe de ser de mas de 5 caracteres';
            },
          ),
          const SizedBox(height: 10),
          TextFormField(
            autocorrect: false,
            decoration: InputDecorations.authInputDecoration(labelText: 'Usuario', prefixIcon: Icons.person),
            // onChanged: (value) => loginForm.usuario = value,
            validator: (value) {
              if (value != null && value.length >= 6) {
                return null;
              }
              return 'El usuario debe de ser de mas de 5 caracteres';
            },
          ),
          const SizedBox(height: 10),
          TextFormField(
            autocorrect: false,
            obscureText: true,
            keyboardType: TextInputType.text,
            decoration: InputDecorations.authInputDecoration(
              labelText: 'Clave',
              prefixIcon: Icons.lock_outlined,
            ),
            // onChanged: (value) => loginForm.clave = value,
            validator: (value) {
              if (value != null && value.length >= 6) {
                return null;
              }
              return 'La contraseña debe tener mas de 5 caracteres';
            },
          ),
          const SizedBox(height: 20),
          // MaterialButton(
          //   shape:
          //       RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          //   disabledColor: Colors.grey,
          //   color: Colors.blue[900],
          // onPressed: loginForm.isLoading
          //     ? null
          //     : () async {
          //         if (!loginForm.isValidForm()) return;

          //         FocusScope.of(context).unfocus();
          //         loginForm.isLoading = true;

          //         final authService =
          //             Provider.of<AuthService>(context, listen: false);

          //         final String? errorMessage = await authService.createUser(
          //             loginForm.nombre, loginForm.usuario, loginForm.clave);
          //         if (errorMessage == null) {
          //           Navigator.popAndPushNamed(context, 'home');
          //         } else {
          //           NotificationsService.showSnackBar(errorMessage);
          //           loginForm.isLoading = false;
          //         }
          //       },
          // child: Container(
          //   padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
          //   child: Text(
          //     loginForm.isLoading ? 'Espere...' : 'Registrar',
          //     style: const TextStyle(color: Colors.white),
          //   ),
          // ),
          // ),
        ],
      ),
    );
  }
}
