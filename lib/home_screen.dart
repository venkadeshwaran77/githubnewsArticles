import 'dart:developer';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_articles/const/vars.dart';
import 'package:news_articles/inner%20screens/search_screen.dart';
import 'package:news_articles/provider/news_provider.dart';
import 'package:news_articles/services/utiles.dart';
import 'package:news_articles/widgets/articles_widgets.dart';
import 'package:news_articles/widgets/drawer_widgets.dart';
import 'package:news_articles/widgets/empty_screen.dart';
import 'package:news_articles/widgets/loading_widgets.dart';
import 'package:news_articles/widgets/tabs.dart';
import 'package:news_articles/widgets/top_trending_widget.dart';
import 'package:news_articles/widgets/verticle_spacing.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '../models/news_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var newsType = NewsType.allNews;
  int currentPageIndex = 0;
  String sortBy = SortByEnum.publishedAt.name;

  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).getScreenSize;
    final Color color = Utils(context).getColor;
    final newsProvider = Provider.of<NewsProvider>(context);
    
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: color),
          elevation: 0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          centerTitle: true,
          title: Text(
            'News app',
            style: GoogleFonts.lobster(
              textStyle: TextStyle(
                color: color,
                fontSize: 20,
                letterSpacing: 0.6,
              ),
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.rightToLeft,
                    child: const SearchScreen(),
                    inheritTheme: true,
                    ctx: context,
                  ),
                );
              },
              icon: const Icon(IconlyLight.search),
            ),
          ],
        ),
        drawer: const DrawerWidgets(),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  TabsWidget(
                    text: 'All news',
                    color:
                        newsType == NewsType.allNews
                            ? Theme.of(context).cardColor
                            : Colors.transparent,
                    function: () {
                      if (newsType == NewsType.allNews) {
                        return;
                      }
                      setState(() {
                        newsType = NewsType.allNews;
                      });
                    },
                    fontSize: newsType == NewsType.allNews ? 22 : 14,
                  ),
                  const SizedBox(width: 25),
                  TabsWidget(
                    text: 'Top trending',
                    color:
                        newsType == NewsType.topTrending
                            ? Theme.of(context).cardColor
                            : Colors.transparent,
                    function: () {
                      if (newsType == NewsType.topTrending) {
                        return;
                      }
                      setState(() {
                        newsType = NewsType.topTrending;
                      });
                    },
                    fontSize: newsType == NewsType.topTrending ? 22 : 14,
                  ),
                ],
              ),
              VerticleSpacing(10),
              newsType == NewsType.topTrending
                  ? Container()
                  : SizedBox(
                    height: kBottomNavigationBarHeight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        paginationButtons(
                          text: "Prev",
                          function: () {
                            if (currentPageIndex == 0) {
                              return;
                            }
                            setState(() {
                              currentPageIndex -= 1;
                            });
                          },
                        ),
                        Flexible(
                          flex: 2,
                          child: ListView.builder(
                            itemCount: 5,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: ((context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Material(
                                  color:
                                      currentPageIndex == index
                                          ? Colors.blue
                                          : Theme.of(context).cardColor,
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        currentPageIndex = index;
                                      });
                                    },
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text("${index + 1}"),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ),
                        ),
                        paginationButtons(
                          text: "Next",
                          function: () {
                            if (currentPageIndex == 4) {
                              return;
                            }
                            setState(() {
                              currentPageIndex += 1;
                            });
                            // print('$currentPageIndex index');
                          },
                        ),
                      ],
                    ),
                  ),
              VerticleSpacing(10),
              newsType == NewsType.topTrending
                  ? Container()
                  : Align(
                    alignment: Alignment.topRight,
                    child: Material(
                      color: Theme.of(context).cardColor,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: DropdownButton(
                          value: sortBy,
                          items: dropDownItems,
                          onChanged: (String? value) {
                            setState(() {
                              sortBy = value!;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
              FutureBuilder<List<NewsModel>>(
                future: newsType == NewsType.topTrending 
              ? newsProvider.fetchTopHeadlines()
              : newsProvider.fetchAllNews(
                 pageIndex: currentPageIndex + 1,
                  sortBy: sortBy),
                builder: ((context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return newsType == NewsType.allNews
                        ? LoadingWidgets(newsType: newsType)
                        : Expanded(child: LoadingWidgets(newsType: newsType));
                  } else if (snapshot.hasError) {
                    return Expanded(
                      child: EmptyNewsWidget(
                        text: "an error occured ${snapshot.error}",
                        imagePath: 'assets/images/no_news.png',
                      ),
                    );
                  } else if (snapshot.data == null) {
                    return const Expanded(
                      child: EmptyNewsWidget(
                        text: "No news found",
                        imagePath: 'assets/images/no_news.png',
                      ),
                    );
                  }
                  return newsType == NewsType.allNews
                      ? Expanded(
                        child: ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (ctx, index) {
                            return ChangeNotifierProvider.value(
                              value: snapshot.data![index],
                              child: const ArticlesWidgets(
                                // imageUrl: snapshot.data![index].,
                                // dateToShow: snapshot.data![index].dateToShow,
                                // readingTime:
                                //     snapshot.data![index].readingTimeText,
                                // title: snapshot.data![index].title,
                                // url: snapshot.data![index].url,
                              ),
                            );
                          },
                        ),
                      )
                      : SizedBox(
                        height: size.height * 0.6,
                        child: Swiper(
                          autoplayDelay: 8000,
                          autoplay: true,
                          itemWidth: size.width * 0.9,
                          layout: SwiperLayout.STACK,
                          viewportFraction: 0.9,
                          itemCount: 5,
                          itemBuilder: (context, index) {
                            return  ChangeNotifierProvider.value(
                              value: snapshot.data![index],
                               child: TopTrendingWidget(
                                //url: snapshot.data![index].url,
                              ),
                            );
                          },
                        ),
                      );
                }),
              ),
              //  LoadingWidget(newsType: newsType),
            ],
          ),
        ),
      ),
    );
  }

  List<DropdownMenuItem<String>> get dropDownItems {
    List<DropdownMenuItem<String>> menuItem = [
      DropdownMenuItem(
        value: SortByEnum.relevancy.name,
        child: Text(SortByEnum.relevancy.name),
      ),
      DropdownMenuItem(
        value: SortByEnum.publishedAt.name,
        child: Text(SortByEnum.publishedAt.name),
      ),
      DropdownMenuItem(
        value: SortByEnum.popularity.name,
        child: Text(SortByEnum.popularity.name),
      ),
    ];
    return menuItem;
  }

  Widget paginationButtons({required Function function, required String text}) {
    return ElevatedButton(
      onPressed: () {
        function();
      },
      child: Text(text),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
        padding: EdgeInsets.all(6),
        textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}
