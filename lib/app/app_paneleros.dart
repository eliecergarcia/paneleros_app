import 'package:flutter/material.dart';

import 'package:paneleros_app/app/pages/home_page.dart';
import 'package:paneleros_app/app/pages/emisora_page.dart';
import 'package:paneleros_app/app/pages/biblioteca_page.dart';
import 'package:paneleros_app/app/pages/podcast_page.dart';
import 'package:paneleros_app/app/pages/cursos_page.dart';
import 'package:paneleros_app/app/pages/splash_page.dart';

class AppPaneleros extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cenicaña',
      theme: ThemeData(
          primaryColor: Colors.blue.shade500,
          textSelectionTheme: TextSelectionThemeData(
            selectionColor: Colors.blue.shade500,
          ),
          buttonColor: Colors.blue.shade500,
          accentColor: Colors.blue.shade500,
          bottomAppBarColor: Colors.white),
      home: SplashPage(),
      routes: {
        SplashPage.routeName: (BuildContext context) => SplashPage(),
        HomePage.routeName: (BuildContext context) => HomePage(),
        EmisoraPage.routeName: (BuildContext context) => EmisoraPage(),
        BibliotecaPage.routeName: (BuildContext context) => BibliotecaPage(),
        PodcastPage.routeName: (BuildContext context) => PodcastPage(),
        CursosPage.routeName: (BuildContext context) => CursosPage(),
      },
    );
  }
}
