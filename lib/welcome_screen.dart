import 'package:flutter/material.dart';
import 'package:news_articles/auth/login_page.dart';
import 'package:news_articles/auth/signup_page.dart';
import 'package:news_articles/custom_scaffold.dart';
import 'package:news_articles/thems/colors_theme.dart';
import 'package:news_articles/welcome_button.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
    child:Column(
      children: [
        Flexible(
          flex:8,
          child:Image.asset("assets/img/news.png"),
          ),
        Flexible(
          flex: 7,
          child:Align(
            alignment:Alignment.bottomRight,
            child: Row(
              
            children: [
              Expanded(
                child: WelcomeButton(
                  buttonText:"Log In",
                 onTap:LogInScreen(),
                 color:Colors.transparent,
                 textColor:Colors.white,
                ),
                ),
               Expanded(
                child: WelcomeButton(
                  buttonText:"Sign Up", 
                  onTap:SignupScreen(),
                  color:Colors.white,
                  textColor:lightColorScheme.primary,
                ),
                ),
            ],
                    ),
          ),),
      ],
    ),
    );
  }
}
