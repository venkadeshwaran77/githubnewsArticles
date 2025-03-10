import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:news_articles/auth/login_page.dart';
import 'package:news_articles/auth/signup_page.dart';
import 'package:news_articles/home_screen.dart';
import 'package:news_articles/theme.dart';
import 'package:news_articles/thems/theme_provider.dart';
import 'package:news_articles/welcome_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]).then(
    (_) {
      runApp(MyApp());
    },
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    bool _isDark = true;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: style.themeData(true, context),
      
      //home:WelcomeScreen(),
      initialRoute: 'welcome_screen',
      routes: {
        'welcome_screen': (context) => WelcomeScreen(),
        'login_screen': (context) => LogInScreen(),
        'signup_screen': (context) => SignupScreen(),
        'home_screen': (context) => NewsScreen(),
      },
    );
  }
}
