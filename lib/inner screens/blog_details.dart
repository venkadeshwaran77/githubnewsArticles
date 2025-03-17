import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_articles/services/utiles.dart';
import 'package:news_articles/widgets/verticle_spacing.dart';

import '../const/styles.dart';

class NewsDetailsScreen extends StatefulWidget {
  static const routeName = "NewsDetailsScreen";
  const NewsDetailsScreen({super.key});

  @override
  State<NewsDetailsScreen> createState() => _NewsDetailsScreenState();
}

class _NewsDetailsScreenState extends State<NewsDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final color = Utils(context).getColor;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: color),
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        centerTitle: true,
        title: Text(
          "By Author",
          textAlign: TextAlign.center,
          style: TextStyle(color: color),
        ),
        /* leading: IconButton(
          icon: Icon(
            IconlyLight.arrowLeft
            ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),*/
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Title" * 10,
                  textAlign: TextAlign.justify,
                  style: titleTextStyle,
                ),
                VerticleSpacing(25),
                Row(
                  children: [
                    Text("17/03/2025",
                     style:smallTextStyle),
                    Spacer(),
                    Text("readingTimeText", 
                    style:smallTextStyle),
                  ],
                ),
                VerticleSpacing(20),
              ],
            ),
          ),
          Stack(
           children: [
            SizedBox(
              width:double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(bottom:25),
                child: FancyShimmerImage(
                  boxFit: BoxFit.fill,
               errorWidget:Image.asset('assets/img/emty.jpg'),
                imageUrl:
              "https://techcrunch.com/wp-content/uploads/2022/01/locket-app.jpg?resize=1536,864",
              ),
              ),
            ),
            Positioned(
              bottom:0,
              right:10,
              child: Padding(
                padding: const EdgeInsets.only(right:10),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap:(){},
                      child:Card(
                      elevation:10,
                      shape:CircleBorder(),
                      child:Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                        IconlyLight.send,
                        size:28,
                        color:color,
                        ),
                      ),
                      ),
                    ),
                     GestureDetector(
                      onTap:(){},
                      child:Card(
                      elevation:10,
                      shape:CircleBorder(),
                      child:Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                        IconlyLight.bookmark,
                        size:28,
                        color:color,
                        ),
                      ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
           ],
          ),
          VerticleSpacing(20),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextContent(
                  label: "Description",
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                VerticleSpacing(10),
                TextContent(
                  label: "description" * 12,
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                ),
                VerticleSpacing(20),
                TextContent(
                  label: 'Contents',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                VerticleSpacing(10),
                TextContent(
                  label: 'content' * 12,
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                ),
                VerticleSpacing(10),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TextContent extends StatelessWidget {
  const TextContent({
    super.key,
    required this.label,
    required this.fontSize,
    required this.fontWeight,
  });
  final String label;
  final double fontSize;
  final FontWeight fontWeight;
  @override
  Widget build(BuildContext context) {
    return SelectableText(
      label,
      textAlign:TextAlign.justify,
      style:GoogleFonts.roboto(fontSize:fontSize,fontWeight:fontWeight),
    );
  }
}
