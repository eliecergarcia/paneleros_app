import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'home_page.dart';

class PodcastPage extends StatefulWidget {
  static final String routeName = 'podcast';

  @override
  State<StatefulWidget> createState() {
    return _PodcastPageState();
  }
}

class _PodcastPageState extends State<PodcastPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  var _url = 'http://agrogestion.com.co/app/playlist.html';
  final _key = UniqueKey();

  @override
  void initState() {
    super.initState();
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Podcast'),
        automaticallyImplyLeading: true,
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(_scaffoldKey.currentContext)
                .pushReplacementNamed(HomePage.routeName)),
      ),
      body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16.0),
          padding: const EdgeInsets.all(8.0),
          child:  WebView(
                    key: _key,
                    javascriptMode: JavascriptMode.unrestricted,
                    initialUrl: _url)),
    );
  }
}
