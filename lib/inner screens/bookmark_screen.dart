import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_articles/const/vars.dart';
import 'package:news_articles/models/bookmarks_model.dart';
import 'package:news_articles/provider/bookmarks_provider.dart';
import 'package:news_articles/services/utiles.dart';
import 'package:news_articles/widgets/articles_widgets.dart';
import 'package:news_articles/widgets/drawer_widgets.dart';
import 'package:news_articles/widgets/empty_screen.dart';
import 'package:news_articles/widgets/loading_widgets.dart';
import 'package:provider/provider.dart';

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
      drawer: DrawerWidgets(),
      appBar: AppBar(
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
      body: Column(
        children: [
          FutureBuilder<List<BookmarksModel>>(
            future:Provider.of<BookmarksProvider>(context, listen: false)
            .fetchBookmarks(),
           builder: ((context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return LoadingWidgets(newsType: NewsType.allNews);
              } else if (snapshot.hasError) {
                return Expanded(
                  child: EmptyNewsWidget(
                    text: "an error occured ${snapshot.error}",
                    imagePath: 'assets/images/no_news.png',
                  ),
                );
              } else if (snapshot.data == null) {
                return EmptyNewsWidget(
                  text: 'You didn\'t add anything yet to your bookmarks',
                  imagePath: "assets/img/book.png",
                );
              }
              return Expanded(
                child: ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return ChangeNotifierProvider.value(
                      value:snapshot.data![index],
                      child: ArticlesWidgets(isBookmark: true),
                      );
                  },
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
