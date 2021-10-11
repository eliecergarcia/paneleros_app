import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:paneleros_app/app/api/apisql.dart';
import 'package:paneleros_app/app/pages/signup_page.dart';
import 'package:paneleros_app/app/pages/splash_page.dart';
import 'package:paneleros_app/app/pages/update_password_page.dart';
import 'package:paneleros_app/app/widgets/inputfile.dart';

class LoginPage extends StatefulWidget {
  static final String routeName = 'login_page';
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _email, _password;
  bool correctEmail = true;
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
                        "La Voz De Los Paneleros\nIniciar Sesión",
                        textAlign: TextAlign.center,
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
                          validator: validateEmail,
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
                        disabledTextColor: Colors.grey,
                        disabledColor: Colors.grey,
                        minWidth: double.infinity,
                        height: 60,
                        onPressed: (correctEmail)
                            ? () async {
                                _isInAsyncCall = true;
                                if (_password == null || _email == null) {
                                  _showAlertTextFieldEmpty(context);
                                } else {
                                  loginSucces = await apiConnect.login(
                                      _email, _password, context);
                                  if (loginSucces) {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => SplashPage(),
                                      ),
                                    );
                                  } else {
                                    _showAlertLoginFail(context);
                                  }
                                }
                                _isInAsyncCall = false;
                              }
                            : null,
                        color: Color(0xff0095FF),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Text(
                          "Iniciar Sesión ",
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
                        builder: (context) => UpdatePasswordPage(),
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
                          "Regístrate",
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

//validacion del correo
  String validateEmail(String value) {
    final Pattern pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value)) {
      correctEmail = false;
      return 'Ingresa un Correo Valido';
    } else {
      correctEmail = true;
      return null;
    }
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
