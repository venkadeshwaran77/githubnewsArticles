import 'package:flutter/material.dart';
import 'package:news_articles/widgets/drawer_widgets.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    
     return SafeArea(
       child: Scaffold(
        appBar:AppBar(
          backgroundColor:Theme.of(context).scaffoldBackgroundColor,
        ),
        drawer: DrawerWidgets(),
        body: Container(
        ),
            
      ),
    );
  }
}
