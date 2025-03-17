import 'package:flutter/material.dart';
import 'package:news_articles/auth/login_page.dart';
import 'package:news_articles/auth/signup_page.dart';
import 'package:news_articles/home_screen.dart';
import 'package:news_articles/inner%20screens/blog_details.dart';
import 'package:news_articles/provider/theme_provider.dart';
import 'package:news_articles/thems/theme_data.dart'; 
import 'package:news_articles/welcome_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeProvider themeChangeProvider = ThemeProvider();

  

  @override
  void initState() {
    getCurrentAppTheme();
    super.initState();
  }
  void getCurrentAppTheme() async {
    themeChangeProvider.setDarkTheme =
        await themeChangeProvider.darkThemePreferences.getTheme();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) {
            return themeChangeProvider;
          },
        ),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeChangeProvider, ch) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title:'News App',
            theme: style.themeData(themeChangeProvider.getDarkTheme, context),
            
            //home:WelcomeScreen(),
            initialRoute: 'welcome_screen',
            routes: {
              'welcome_screen': (context) => WelcomeScreen(),
              'login_screen': (context) => LogInScreen(),
              'signup_screen': (context) => SignupScreen(),
              'home_screen': (context) => NewsScreen(),
              NewsDetailsScreen.routeName:(context) => NewsDetailsScreen(),
            },
          );
        },
      ),
    );
  }
}
