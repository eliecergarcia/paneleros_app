import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:paneleros_app/app/api/apisql.dart';
import 'package:paneleros_app/app/widgets/inputfile.dart';

class SignupPage extends StatefulWidget {
  static final String routeName = 'signup_page';
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool _inAsyncCall = false;
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
      _cellphone;
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
                      "Registrate",
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
                      label: "Correo",
                      function: (value) {
                        setState(() {
                          _email = value;
                        });
                      },
                    ),
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
                    Text('Aceptas los terminos y condiciones'),
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
                    minWidth: double.infinity,
                    height: 60,
                    onPressed: () async {
                      //await apiConnect.createUser('firstName', 'secondName', 'firstLastName', 'secondLastName', 'email', 'password', 'apartment', 15, 1);
                      setState(() {
                        if (_firstName == null ||
                            _secondName == null ||
                            _lastName == null ||
                            _email == null ||
                            _apartment == null ||
                            _cellphone == null ||
                            _password == null ||
                            _rePassword == null) {
                          _showAlertTextFieldEmpty(context);
                        } else if (_rePassword != _password) {
                          _showAlertTextPasswordIncorrect(context);
                        }
                      });
                    },
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("¿Ya tienes una cuenta?"),
                    Text(
                      " Inicia Sesión",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                    )
                  ],
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
