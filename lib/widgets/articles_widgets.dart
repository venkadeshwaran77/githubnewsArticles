import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:news_articles/const/vars.dart';
import 'package:news_articles/inner%20screens/blog_details.dart';
import 'package:news_articles/inner%20screens/news_details_webview.dart';
import 'package:news_articles/models/bookmarks_model.dart';
import 'package:news_articles/models/news_model.dart';
import 'package:news_articles/services/utiles.dart';
import 'package:news_articles/widgets/verticle_spacing.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class ArticlesWidgets extends StatelessWidget {
  const ArticlesWidgets({super.key, this.isBookmark = false});
  // final String imageUrl, title, url, dateToShow,readingTime;
  final bool isBookmark;
  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).getScreenSize;
    dynamic newsModelProvider =
        isBookmark
            ? Provider.of<BookmarksModel>(context)
            : Provider.of<NewsModel>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: Theme.of(context).cardColor,
        child: GestureDetector(
          onTap: () {
            // Navigate to the in app details screen
            Navigator.pushNamed(
              context,
              NewsDetailsScreen.routeName,
              arguments: newsModelProvider.publishedAt,
            );
          },
          child: Stack(
            children: [
              Container(
                height: 60,
                width: 60,
                color: Theme.of(context).colorScheme.secondary,
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  height: 60,
                  width: 60,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              Container(
                color: Theme.of(context).cardColor,
                padding: EdgeInsets.all(10.0),
                margin: EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Hero(
                        tag: newsModelProvider.publishedAt,
                        child: FancyShimmerImage(
                          height: size.height * 0.12,
                          width: size.height * 0.12,
                          boxFit: BoxFit.fill,
                          errorWidget: Image.asset('assets/img/emty.jpg'),
                          imageUrl: newsModelProvider.urlToImage,
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            newsModelProvider.title,
                            textAlign: TextAlign.justify,
                            style: smallTextStyle,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          VerticleSpacing(5),
                          Align(
                            alignment: Alignment.topRight,
                            child: Text(
                              '⏳ ${newsModelProvider.readingTimeText}',
                              style: smallTextStyle,
                            ),
                          ),
                          FittedBox(
                            child: Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      PageTransition(
                                        type: PageTransitionType.rightToLeft,
                                        child: NewsDetailsWebview(
                                          url: newsModelProvider.url,
                                        ),
                                        inheritTheme: true,
                                        ctx: context,
                                      ),
                                    );
                                  },
                                  icon: Icon(Icons.link, color: Colors.blue),
                                ),
                                Text(
                                  newsModelProvider.dateToShow,
                                  maxLines: 1,
                                  style: smallTextStyle,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
