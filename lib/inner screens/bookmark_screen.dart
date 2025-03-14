import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_articles/services/utiles.dart';
import 'package:news_articles/widgets/empty_screen.dart';

class BookmarkScreen extends StatefulWidget {
  const BookmarkScreen({super.key});

  @override
  State<BookmarkScreen> createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).getScreenSize;
    final Color color = Utils(context).getColor;
    return Scaffold(
      appBar:AppBar(
      iconTheme: IconThemeData(color: color),
          elevation: 0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          centerTitle: true,
          title: Text(
            'Bookmarks',
            style: GoogleFonts.lobster(
              textStyle: TextStyle(
                color: color,
                fontSize: 20,
                letterSpacing: 0.6,
              ),
            ),
          ),
         ),
       body:EmptyNewsWidget(
        text:'You didn\'t add anything yet to your bookmarks',
        imagePath: "assets/img/book.png",
        ),
       /* ListView.builder(
          itemCount: 20,
        itemBuilder: (context, index) {
         return ArticlesWidgets();
        },
       ),*/
    );
  }
}
