import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:paneleros_app/app/api/apisql.dart';
import 'package:paneleros_app/app/pages/home_page.dart';
import 'package:paneleros_app/app/pages/recoverpassword_page.dart';
import 'package:paneleros_app/app/pages/signup_page.dart';
import 'package:paneleros_app/app/widgets/inputfile.dart';

class LoginPage extends StatefulWidget {
  static final String routeName = 'login_page';
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _email, _password;
  ApiConnect apiConnect = ApiConnect();
  bool _isInAsyncCall = false;
  bool loginSucces = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: ModalProgressHUD(
        inAsyncCall: _isInAsyncCall,
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      const Text(
                        "Iniciar Sesion",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: Column(
                      children: <Widget>[
                        inputFile(
                          label: "Correo",
                          function: (value) {
                            setState(() {
                              _email = value;
                            });
                          },
                        ),
                        inputFile(
                          label: "Contraseña",
                          obscureText: true,
                          function: (value) {
                            setState(() {
                              _password = value;
                            });
                          },
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: Container(
                      padding: EdgeInsets.only(top: 3, left: 3),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border(
                          bottom: BorderSide(color: Colors.black),
                          top: BorderSide(color: Colors.black),
                          left: BorderSide(color: Colors.black),
                          right: BorderSide(color: Colors.black),
                        ),
                      ),
                      child: MaterialButton(
                        minWidth: double.infinity,
                        height: 60,
                        onPressed: () async {
                          _isInAsyncCall = true;
                          if (_password == null || _email == null) {
                            _showAlertTextFieldEmpty(context);
                          } else {
                            loginSucces =
                                await apiConnect.login(_email, _password);
                            if (loginSucces) {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomePage()));
                            } else {
                              _showAlertLoginFail(context);
                            }
                          }
                          _isInAsyncCall = false;
                        },
                        color: Color(0xff0095FF),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Text(
                          "Iniciar Sesión",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RecoverPasswordPage(),
                      ),
                    ),
                    child: Text(
                      "¿Olvidaste tu contraseña?",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("¿No tienes una cuenta?"),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignupPage(),
                              ),
                            );
                          });
                        },
                        child: Text(
                          "Registrate",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 100),
                    height: 200,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/background.png"),
                          fit: BoxFit.fitHeight),
                    ),
                  )
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showAlertTextFieldEmpty(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Favor de llenar todos los campos',
            textAlign: TextAlign.center,
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text(
                  'El campo de contraseña o correo no se permite que sean vacios.',
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showAlertLoginFail(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Inicio de Sesión Invalido',
            textAlign: TextAlign.center,
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text(
                  'Favor de ingresar el correo o la contraseña correctos!',
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
