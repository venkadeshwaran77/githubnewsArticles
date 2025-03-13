import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_articles/services/utiles.dart';

class TopTrendingWidget extends StatelessWidget {
  const TopTrendingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = Utils(context).getScreenSize;
    final Color color = Utils(context).getColor;
    return Padding(
      padding: EdgeInsets.all(10.0),
       child: Material(
           color: Theme.of(context).cardColor,
            borderRadius:BorderRadius.circular(12.0),
            child: InkWell(
             onTap: () {},
            child:Column(
              crossAxisAlignment:CrossAxisAlignment.start,
              //mainAxisAlignment:MainAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius:BorderRadius.circular(12),
                  child:FancyShimmerImage(
                    boxFit:BoxFit.fill,
                    errorWidget:Image.asset('assets/img/emty.jpg'),
                    imageUrl:"https://techcrunch.com/wp-content/uploads/2022/01/locket-app.jpg?resize=1536,864",
                    height:size.height *0.33,
                    width:double.infinity,
                    ),
                  ),
                  Padding(
                    padding:EdgeInsets.all(8.0),
                    child:Text(
                      "Title",
                      style:TextStyle(fontWeight:FontWeight.bold,fontSize:24),
                      ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed:() async {}, 
                      icon:Icon(Icons.link,
                      color:color,
                      ),
                      ),
                      Spacer(),
                      SelectableText(
                      "13-03-2025",
                      style:GoogleFonts.montserrat(fontSize:15), 
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
