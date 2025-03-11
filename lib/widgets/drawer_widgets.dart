import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:news_articles/provider/theme_provider.dart';

import 'package:news_articles/widgets/verticle_spacing.dart';
import 'package:provider/provider.dart';

class DrawerWidgets extends StatefulWidget {
  const DrawerWidgets({super.key});

  @override
  State<DrawerWidgets> createState() => _DrawerWidgetsState();
}

class _DrawerWidgetsState extends State<DrawerWidgets> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Drawer(
      child: Material(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Theme.of(context).primaryColor),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Image.asset(
                      'assets/img/news1.png',
                      height: 60,
                      width: 60,
                    ),
                  ),
                  VerticleSpacing(20),

                  Flexible(child: Text('News app')),
                ],
              ),
            ),
            VerticleSpacing(20),
            listTiles(
              lable: 'Home', 
              icon:IconlyBold.home,
            fct: () {}
            ),
             listTiles(
              lable: 'Bookmark', 
              icon:IconlyBold.bookmark,
            fct: () {}
            ),
            Divider(thickness:5),
             SwitchListTile(
              title: Text(
                themeProvider.getDarkTheme ?'Dark' : 'Light',
                ),
                
              secondary: Icon(
                themeProvider.getDarkTheme
                    ? Icons.dark_mode_outlined
                    : Icons.light_mode_outlined,
                    color: Theme.of(context).colorScheme.secondary,
              ),
                value:themeProvider.getDarkTheme,
              onChanged: (bool value) {
              setState(() {
                 themeProvider.setDarkTheme = value;
               });
               } ,  
            
          
              ),
          ],
        ),
      ),
    );
  }
}

class listTiles extends StatelessWidget {
  const listTiles({super.key, required this.lable, required this.fct, required this.icon});
  final String lable;
  final Function fct;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(lable, style: TextStyle(fontSize: 20)),
      onTap: () {
        fct();
      },
    );
  }
}
