import 'package:flutter/material.dart';
import 'package:news_articles/services/utiles.dart';

class EmptyNewsWidget extends StatelessWidget {
  const EmptyNewsWidget({super.key, required this.text, required this.imagePath});
  final String text,imagePath;
  @override
  Widget build(BuildContext context) {
    Color color = Utils(context).getColor;
    return Padding(
      padding: EdgeInsets.all(8.0),
      child:Column(
        mainAxisAlignment:MainAxisAlignment.center,
        crossAxisAlignment:CrossAxisAlignment.center,
        mainAxisSize:MainAxisSize.max,
        children: [
          Padding(
            padding:EdgeInsets.all(18.0),
            child:Image.asset(
              imagePath,
            ),
          ),
          Text(
            text,
            textAlign:TextAlign.center,
            style:TextStyle(
              color:color,
              fontSize:30,
              fontWeight:FontWeight.w700,
            ),
          ),
        ],
      ),
      );
  }
}
