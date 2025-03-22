import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_articles/inner%20screens/blog_details.dart';
import 'package:news_articles/inner%20screens/news_details_webview.dart';
import 'package:news_articles/models/news_model.dart';
import 'package:news_articles/services/utiles.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class TopTrendingWidget extends StatelessWidget {
  const TopTrendingWidget({super.key});
  // final String url;

  @override
  Widget build(BuildContext context) {
    final size = Utils(context).getScreenSize;
    final Color color = Utils(context).getColor;
    final newsModelProvider = Provider.of<NewsModel>(context);
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Material(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12.0),
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(
              context,
              NewsDetailsScreen.routeName,
              arguments: newsModelProvider.publishedAt,
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            //mainAxisAlignment:MainAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: FancyShimmerImage(
                  boxFit: BoxFit.fill,
                  errorWidget: Image.asset('assets/img/emty.jpg'),
                  imageUrl: newsModelProvider.urlToImage,
                  height: size.height * 0.33,
                  width: double.infinity,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  newsModelProvider.title,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                ),
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.rightToLeft,
                          child: NewsDetailsWebview(url: newsModelProvider.url),
                          inheritTheme: true,
                          ctx: context,
                        ),
                      );
                    },
                    icon: Icon(Icons.link, color: color),
                  ),
                  Spacer(),
                  SelectableText(
                    newsModelProvider.dateToShow,
                    style: GoogleFonts.montserrat(fontSize: 15),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
