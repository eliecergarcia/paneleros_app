import 'dart:io';

import 'package:flutter/material.dart';
import 'package:paneleros_app/app/pages/pdf_page.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'home_page.dart';

class BibliotecaPage extends StatefulWidget {
  static final String routeName = 'biblioteca';

  @override
  State<StatefulWidget> createState() {
    return _BibliotecaPagePageState();
  }
}

class _BibliotecaPagePageState extends State<BibliotecaPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  var _url = 'http://agrogestion.com.co/app/biblioteca.html';
  final _key = UniqueKey();

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  // @override
  // void setState(fn) {
  //   if (mounted) {
  //     super.setState(fn);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Biblioteca'),
        automaticallyImplyLeading: true,
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(_scaffoldKey.currentContext)
                .pushReplacementNamed(HomePage.routeName)),
      ),
      body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16.0),
          padding: const EdgeInsets.all(8.0),
          child: WebView(
            //key: _key,
            javascriptMode: JavascriptMode.unrestricted,
            debuggingEnabled: true,
            initialUrl: _url,
            navigationDelegate: (NavigationRequest request) async {
              await launch(request.url);
              return null;
            },
            // navigationDelegate: (NavigationRequest request) async {
            //   if (request.url.endsWith('.pdf')) {
            //     Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //           builder: (context) => ViewPdfPage(request.url),
            //         ));

            //     return NavigationDecision.navigate;
            //   }
            //   return NavigationDecision.navigate;
            // },
            gestureNavigationEnabled: true,
          )),
    );
  }
}
