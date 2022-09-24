import 'package:celula_app/screens/home_screen.dart';
import 'package:celula_app/screens/login_screen.dart';
import 'package:celula_app/screens/register_screen.dart';
import 'package:celula_app/services/auth_service.dart';
import 'package:celula_app/services/notifications_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(const AppState());

class AppState extends StatelessWidget {
  const AppState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // ChangeNotifierProvider(create: ( _ ) => ProductService()),
        ChangeNotifierProvider(create: (_) => AuthService()),
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
        'home': (_) => const HomeScreen()
      },
      theme: ThemeData.light().copyWith(
          scaffoldBackgroundColor: Colors.grey[300],
          appBarTheme: const AppBarTheme(color: Colors.indigo)),
    );
  }
}
