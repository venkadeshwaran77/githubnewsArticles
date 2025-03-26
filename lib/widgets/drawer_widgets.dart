import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_articles/home_screen.dart';
import 'package:news_articles/inner%20screens/bookmark_screen.dart';
import 'package:news_articles/provider/theme_provider.dart';
import 'package:news_articles/widgets/verticle_spacing.dart';
import 'package:page_transition/page_transition.dart';
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
    themeProvider.getDarkTheme ? Colors.white : Colors.black;
    return Drawer(
      child: Material(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Theme.of(context).cardColor),
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

                  Flexible(
                    child: Text(
                      'News app',
                      style: GoogleFonts.lobster(
                        textStyle: TextStyle(fontSize: 20, letterSpacing: 0.6),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            VerticleSpacing(20),
            ListTilesWidget(lable: 'Home', 
            icon: IconlyBold.home, fct: () {
               Navigator.pushReplacement(
                  context, PageTransition(
                type: PageTransitionType.rightToLeft,
                child:HomeScreen(),
                inheritTheme:true,
                ctx:context
                ),
                );
            }),
               ListTilesWidget(
              lable: 'Bookmark',
              icon: IconlyBold.bookmark,
              fct: () {
                 Navigator.pushReplacement(
                  context, PageTransition(
                type: PageTransitionType.rightToLeft,
                child:BookmarkScreen(),
                inheritTheme:true,
                ctx:context
                ),
                );
              },
            ),
            Divider(thickness: 5),
            SwitchListTile(
            title: Text(themeProvider.getDarkTheme ? 'Dark' : 'Light',
            style:TextStyle(
              color:Theme.of(context).hintColor,
               fontSize:20,
            ),
              ),
              secondary: Icon(
                themeProvider.getDarkTheme
                    ? Icons.dark_mode_outlined
                    : Icons.light_mode_outlined,
                color: Theme.of(context).colorScheme.secondary,
              ),
              value: themeProvider.getDarkTheme,
              onChanged: (bool value) {
                setState(() {
                  themeProvider.setDarkTheme = value;
                });
              },
              
            ),
            
          ],
        ),
      ),
    );
  }
}

class ListTilesWidget extends StatelessWidget {
  const ListTilesWidget({
    super.key,
    required this.lable,
    required this.fct,
    required this.icon,
  });
  final String lable;
  final Function fct;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon,color: Theme.of(context).colorScheme.secondary),
    
      title: Text(lable,
       style: TextStyle(
        color:Theme.of(context).hintColor,
        fontSize:20
        ),
        ),
      onTap: () {
        fct();
      },
    );
  }
}
