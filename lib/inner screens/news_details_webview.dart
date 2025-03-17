import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:news_articles/services/global_method.dart';
import 'package:news_articles/services/utiles.dart';
import 'package:news_articles/widgets/verticle_spacing.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsDetailsWebview extends StatefulWidget {
  const NewsDetailsWebview({super.key});

  @override
  State<NewsDetailsWebview> createState() => _NewsDetailsWebviewState();
}

class _NewsDetailsWebviewState extends State<NewsDetailsWebview> {
  late WebViewController _webViewController;
  double _progress = 0.0;
  final url =
      "https://www.dailythanthi.com/news/tamilnadu/todays-important-news-in-a-few-lines-15-03-2025-1148083";
  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).getColor;
    return WillPopScope(
      onWillPop: () async {
        if (await _webViewController.canGoBack()) {
          _webViewController.goBack();
          //stay inside
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(IconlyLight.arrowLeft2),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          iconTheme: IconThemeData(color: color),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
          centerTitle: true,
          title: Text("URL", style: TextStyle(color: color)),
          actions: [
            IconButton(
              onPressed: () async {
                await _showModalSheetFct();
              },
              icon: Icon(Icons.more_horiz),
            ),
          ],
        ),
        body: Column(
          children: [
            LinearProgressIndicator(
              value: _progress,
              color: _progress == 1.0 ? Colors.transparent : Colors.blue,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            ),
            Expanded(
              child: WebView(
                initialUrl: Uri.parse(url),
                zoomEnabled: true,
                onprocess: (progress) {
                  setState(() {
                    _progress = progress / 100;
                  });
                },
                onWebViewCreated: (controller) {
                  _webViewController = controller;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showModalSheetFct() async {
    await showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      context: context,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              VerticleSpacing(20),
              Center(
                child: Container(
                  height: 5,
                  width: 35,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
              VerticleSpacing(20),
              Text(
                'More option',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
              ),
              VerticleSpacing(20),
              Divider(thickness: 2),
              VerticleSpacing(20),
              ListTile(
                leading: Icon(Icons.share),
                title: Text('Share'),
                onTap: () async {
                  try {
                    await Share.share('Url', subject: 'Look what I made!');
                  } catch (err) {
                    GlobalMethods.errorDialog(
                      errorMessage: err.toString(),
                      context: context,
                    );
                  }
                },
              ),
              ListTile(
                leading: Icon(Icons.open_in_browser),
                title: Text('Open in browser'),
                onTap: () async {
                  if (!await launchUrl(Uri.parse(url)))
                    throw 'Could not launch $url';
                },
              ),
              ListTile(
                leading: Icon(Icons.refresh),
                title: Text('refresh'),
                onTap: () async {
                  try {
                    await _webViewController.reload();
                  } catch (err) {
                    log("error occured $err");
                  } finally {
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

class WebView extends StatelessWidget {
  const WebView({
    super.key,
    required this.initialUrl,
    required this.zoomEnabled,
    required this.onWebViewCreated,
    required this.onprocess,
  });
  final Uri initialUrl;
  final bool zoomEnabled;
  final dynamic onWebViewCreated;
  final dynamic onprocess;
  @override
  Widget build(BuildContext context) {
    return WebView(
      onprocess: onprocess,
      initialUrl: initialUrl,
      zoomEnabled: zoomEnabled,
      onWebViewCreated: () {},
    );
  }
}
