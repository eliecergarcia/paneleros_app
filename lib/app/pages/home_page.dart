import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  static final String routeName = 'home';

  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  //GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<AnimatedListState> key = GlobalKey();

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
        title: Text('La Voz De Los Paneleros'),
      ),
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
            // image: DecorationImage(
            //   image: AssetImage("assets/images/imginicial.jpg"),
            //   fit: BoxFit.cover,
            // ),
            ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const SizedBox(height: 120),
            Padding(
              padding: const EdgeInsets.all(20),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(_scaffoldKey.currentContext)
                      .pushReplacementNamed('emisora');
                },
                child: Text(
                  'Emisora',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.all(20),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(_scaffoldKey.currentContext)
                      .pushReplacementNamed('biblioteca');
                },
                child: Text(
                  'Biblioteca',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.all(20),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(_scaffoldKey.currentContext)
                      .pushReplacementNamed('podcast');
                },
                child: Text('Podcast',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    )),
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.all(20),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(_scaffoldKey.currentContext)
                      .pushReplacementNamed('cursos');
                },
                child: const Text(
                  'Cursos',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
