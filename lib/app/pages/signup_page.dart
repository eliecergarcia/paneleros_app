import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:paneleros_app/app/api/apisql.dart';
import 'package:paneleros_app/app/widgets/inputfile.dart';
import 'package:url_launcher/url_launcher.dart';

import 'login_page.dart';

class SignupPage extends StatefulWidget {
  static final String routeName = 'signup_page';
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool _inAsyncCall = false;
  bool correctEmail = true, createuser = false;
  ApiConnect apiConnect = ApiConnect();
  bool isChecked = false;
  String _firstName,
      _secondName,
      _lastName,
      _lastNameTwo,
      _email,
      _password,
      _rePassword,
      _apartment,
      _cellphone,
      _city,
      _useInfo;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        // brightness: Brightness.light,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.black,
          ),
        ),
      ),
      body: ModalProgressHUD(
        inAsyncCall: _inAsyncCall,
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 40),
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text(
                      "Regístrate",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Create una cuenta, es gratis!",
                      style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Column(
                  children: <Widget>[
                    inputFile(
                      label: "Primer Nombre",
                      function: (value) {
                        setState(() {
                          _firstName = value;
                        });
                      },
                    ),
                    inputFile(
                      label: "Segundo Nombre",
                      function: (value) {
                        setState(() {
                          _secondName = value;
                        });
                      },
                    ),
                    inputFile(
                      label: "Primer Apellido",
                      function: (value) {
                        setState(() {
                          _lastName = value;
                        });
                      },
                    ),
                    inputFile(
                      label: "Segundo Apellido",
                      function: (value) {
                        setState(() {
                          _lastNameTwo = value;
                        });
                      },
                    ),
                    inputFile(
                      label: "Correo elétronico",
                      function: (value) {
                        setState(() {
                          _email = value;
                        });
                      },
                      validator: validateEmail,
                    ),
                    inputFile(
                        label: 'Municipio',
                        function: (value) {
                          setState(() {
                            _city = value;
                          });
                        }),
                    inputFile(
                      label: "Departamento",
                      function: (value) {
                        setState(() {
                          _apartment = value;
                        });
                      },
                    ),
                    inputFile(
                      label: "Celular",
                      function: (value) {
                        setState(() {
                          _cellphone = value;
                        });
                      },
                      keyboardInput: TextInputType.number,
                    ),
                    inputFile(
                      label: "Contraseña",
                      obscureText: true,
                      function: (value) {
                        setState(() {
                          _password = value;
                        });
                      },
                    ),
                    inputFile(
                      label: "Confirmar Contraseña ",
                      obscureText: true,
                      function: (value) {
                        setState(() {
                          _rePassword = value;
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Checkbox(
                      value: isChecked,
                      onChanged: (value) {
                        setState(() {
                          isChecked = value;
                        });
                      },
                    ),
                    TextButton(
                        onPressed: () async {
                          await launch(
                              'https://www.agrogestion.com.co/docs/Datos%20Personales.pdf');
                        },
                        child: Text('Aceptas los terminos y condiciones')),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
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
                            //await apiConnect.createUser('firstName', 'secondName', 'firstLastName', 'secondLastName', 'email', 'password', 'apartment', 15, 1);

                            if (_firstName == null ||
                                _lastName == null ||
                                _email == null ||
                                _apartment == null ||
                                _cellphone == null ||
                                _password == null ||
                                _rePassword == null) {
                              _showAlertTextFieldEmpty(context);
                            } else if (_rePassword != _password) {
                              _showAlertTextPasswordIncorrect(context);
                            } else {
                              if (isChecked) {
                                _useInfo = 'SI';
                                createuser = await apiConnect.createUser(
                                  _firstName,
                                  _secondName,
                                  _lastName,
                                  _lastNameTwo,
                                  _email,
                                  _password,
                                  _apartment,
                                  int.parse(_cellphone),
                                  _useInfo,
                                  _city,
                                );
                                if (createuser) {
                                  _showAlertSuccess(context).then((_) =>
                                      Navigator.popAndPushNamed(
                                          context, LoginPage.routeName));
                                } else if (!createuser) {
                                  _showFalseSuccess(context);
                                }
                              } else {
                                _showAlertCheckBox(context);
                              }
                            }
                          }
                        : null,
                    color: Color(0xff0095FF),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Text(
                      "Registrarse",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
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
                  'No se permite que ningun campo se encuentre vacio.',
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

  Future<void> _showFalseSuccess(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'El correo ya existe',
            textAlign: TextAlign.center,
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text(
                  'Favor de registrarse con otro correo.',
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

  Future<void> _showAlertSuccess(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Usuario Creado',
            textAlign: TextAlign.center,
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text(
                  'Inicia sesión con tu correo y contraseña proporcionados.',
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

  Future<void> _showAlertCheckBox(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Favor de Aceptar los Terminos y Condiciones',
            textAlign: TextAlign.center,
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text(
                  'Si no son Aceptados no se permite cambiar crear la cuenta.',
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

  Future<void> _showAlertTextPasswordIncorrect(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Las contraseñas no coinciden',
            textAlign: TextAlign.center,
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text(
                  'Favor de ingresar las mismas contraseñas',
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
