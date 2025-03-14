import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

enum NewsType { topTrending, allNews }

enum SortByEnum {
  relevancy, //articles more closely related to q come first.
  popularity, //articles from popular.
  publishedAt, //newest articles come first.
}

TextStyle smallTextStyle = GoogleFonts.montserrat(fontSize: 15);

List<String> searchKeywords = [
  "Football",
  "Cricket",
  "kabbadi",
  "Weather",
  "Python",
  "Flutter",
  "DevOPS",
  "Youtube",
  "crypto",
  "Bitcoin",
  "Netflix",
  "Meta"
];
