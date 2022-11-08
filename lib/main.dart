import 'package:celula_app/screens/home_screen.dart';
import 'package:celula_app/screens/login_screen.dart';
import 'package:celula_app/screens/register_screen.dart';
import 'package:celula_app/services/notifications_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future main() async {
  await dotenv.load();
  runApp(const AppState());
}

class AppState extends StatelessWidget {
  const AppState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Celula App',
      debugShowCheckedModeBanner: false,
      initialRoute: 'login',
      scaffoldMessengerKey: NotificationsService.messengerKey,
      routes: {
        'login': (_) => const LoginScreen(),
        'register': (_) => const RegisterScreen(),
        'home': (_) => const HomeScreen(),
      },
      theme: ThemeData.light()
          .copyWith(scaffoldBackgroundColor: Colors.grey[300], appBarTheme: const AppBarTheme(color: Colors.indigo)),
    );
  }
}
