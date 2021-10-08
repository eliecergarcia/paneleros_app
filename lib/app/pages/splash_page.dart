import 'dart:async';

import 'package:flutter/material.dart';
import 'package:paneleros_app/app/pages/home_page.dart';


class SplashPage extends StatefulWidget {
  static final String routeName = 'splash';

  @override
  State<StatefulWidget> createState() {
    return _SplashPageState();
  }
}

class _SplashPageState extends State<SplashPage> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<AnimatedListState> key = GlobalKey();

  int _pos = 0;
  Timer _timer;

  var images = [
    "http://agrogestion.com.co/app/img/splash1.jpg",
    "http://agrogestion.com.co/app/img/splash2.jpg",
    "http://agrogestion.com.co/app/img/splash3.jpg",
    "http://agrogestion.com.co/app/img/splash4.jpg",
    "http://agrogestion.com.co/app/img/splash5.jpg",
  ];

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

  void changeImage() {
    _timer?.cancel();
    _timer = Timer(Duration(seconds: 3), () {
      if (_pos < 5) {
        setState(() {
          _pos = (_pos + 1);
        });
      }
    });
  }

  Future<Image> _loadImage() async {
    return Image.network(
      images[_pos],
      fit: BoxFit.fill,
      loadingBuilder: (BuildContext context, Widget child,
          ImageChunkEvent loadingProgress) {
        if (loadingProgress == null) {
          changeImage();
          return child;
        }
        return Center(
          child: CircularProgressIndicator(
            value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded /
                    loadingProgress.expectedTotalBytes
                : null,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return _pos < 5
        ? Scaffold(
            key: _scaffoldKey,
            appBar: AppBar(
              title: Text('La Voz De Los Paneleros'),
            ),
            body: Container(
                child: FutureBuilder(
              future: _loadImage(),
              builder: (BuildContext context, AsyncSnapshot<Image> image) {
                if (image.hasData) {
                  return image.data; // image is ready
                } else {
                  return new Container(); // placeholder
                }
              },
            )))
        : HomePage();
  }
}
