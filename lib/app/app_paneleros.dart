import 'package:flutter/material.dart';

import 'package:paneleros_app/app/pages/home_page.dart';
import 'package:paneleros_app/app/pages/emisora_page.dart';
import 'package:paneleros_app/app/pages/biblioteca_page.dart';
import 'package:paneleros_app/app/pages/login_page.dart';
import 'package:paneleros_app/app/pages/podcast_page.dart';
import 'package:paneleros_app/app/pages/cursos_page.dart';
import 'package:paneleros_app/app/pages/recoverpassword_page.dart';
import 'package:paneleros_app/app/pages/signup_page.dart';
import 'package:paneleros_app/app/pages/splash_page.dart';
import 'package:paneleros_app/app/pages/update_password_page.dart';

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
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.blue.shade500,
        ),
        bottomAppBarColor: Colors.white,
        colorScheme:
            ColorScheme.fromSwatch().copyWith(secondary: Colors.blue.shade500),
      ),
      home: LoginPage(),
      routes: {
        LoginPage.routeName: (_) => LoginPage(),
        SignupPage.routeName: (_) => SignupPage(),
        RecoverPasswordPage.routeName: (_) => RecoverPasswordPage(),
        UpdatePasswordPage.id: (_) => UpdatePasswordPage(),
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
