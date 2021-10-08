import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:paneleros_app/app/api/apisql.dart';
import 'package:paneleros_app/app/pages/login_page.dart';
import 'package:paneleros_app/app/widgets/inputfile.dart';

class UpdatePasswordPage extends StatefulWidget {
  static String id = 'update_password_page';
  @override
  State<UpdatePasswordPage> createState() => _UpdatePasswordPageState();
}

class _UpdatePasswordPageState extends State<UpdatePasswordPage> {
  final ApiConnect apiConnect = ApiConnect();
  bool _isInAsyncCall = false;
  bool _existEmail = false;
  bool correctEmail = true;
  String email;
  String password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
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
        inAsyncCall: _isInAsyncCall,
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              columnEmail(),
            ],
          ),
        ),
      ),
    );
  }

  Widget columnEmail() {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: <Widget>[
              const Text(
                "Actualiza tu Contraseña",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
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
                    email = value;
                    value = '';
                  },
                  validator: validateEmail,
                ),
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
                        setState(() async {
                          _isInAsyncCall = true;
                          if (email == null) {
                            _showInValidEmail(context);
                          } else {
                            _existEmail =
                                await apiConnect.updatePassword(email);
                            if (_existEmail) {
                              _showAlertSucces(context);
                            } else {
                              _showTryLater(context);
                            }
                          }
                        });
                      }
                    : null,
                color: Color(0xff0095FF),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Text(
                  "Recupera tu Contraseña",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 100),
            height: 200,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/background.png"),
                  fit: BoxFit.fitHeight),
            ),
          ),
        ],
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

  //alerta de exito
  Future<void> _showAlertSucces(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Contraseña temporal',
            textAlign: TextAlign.center,
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text(
                  'Se te ha enviado un correo con una contraseña temporal, al correo con el cual te registraste.',
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginPage(),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  //alerta de falta de llenar los campos
  Future<void> _showInValidEmail(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Correo Incorrecto',
            textAlign: TextAlign.center,
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text(
                  'Favor de ingresar un correo valido con el que inicias sesion',
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

  //alerta intentalo mas tarde
  Future<void> _showTryLater(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Favor de Intentarlo más tarde',
            textAlign: TextAlign.center,
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text(
                  'Por el momento no se pudo actualizar realizar la petición, favor de interarlo más tarde',
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
