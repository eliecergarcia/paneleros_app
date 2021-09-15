import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:paneleros_app/app/api/apisql.dart';
import 'package:paneleros_app/app/widgets/inputfile.dart';

class RecoverPasswordPage extends StatefulWidget {
  static final String routeName = 'recoverpassword_page';

  @override
  State<RecoverPasswordPage> createState() => _RecoverPasswordPageState();
}

class _RecoverPasswordPageState extends State<RecoverPasswordPage> {
  final ApiConnect apiConnect = ApiConnect();
  bool _isInAsyncCall = false;
  bool _existEmail = false;
  String email;
  String password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
        inAsyncCall: _isInAsyncCall,
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              (_existEmail != true) ? columnEmail() : columnPassword(),
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
        children: <Widget>[
          Column(
            children: <Widget>[
              const Text(
                "Recupera tu Contraseña",
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
                ),
                // inputFile(label: "Contraseña", obscureText: true);
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
                  if (email == null) {
                    _showAlertTextFieldEmpty(context);
                  }
                  _existEmail = await apiConnect.recoverPassword(email);
                  print('$_existEmail');
                  _isInAsyncCall = false;
                  email = '';
                },
                color: Color(0xff0095FF),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Text(
                  "Validar Correo",
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
          )
        ],
      ),
    );
  }

  Widget columnPassword() {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Column(
            children: <Widget>[
              const Text(
                "Ingresa tu Nueva Contraseña",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Contrasena',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: Colors.black87),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey[400]),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey[400]),
                        ),
                      ),
                      onChanged: (value) {},
                    ),
                    SizedBox(
                      height: 10,
                    )
                  ],
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
                minWidth: double.infinity,
                height: 60,
                onPressed: () {
                  setState(() {
                    _isInAsyncCall = true;
                    if (password == null) {
                      _showAlertTextFieldEmpty(context);
                    } else {
                      apiConnect.recoverPassword(email);
                      _isInAsyncCall = false;
                    }
                  });
                },
                color: Color(0xff0095FF),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Text(
                  "Actualiza tu Contraseña",
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
          )
        ],
      ),
    );
  }

  Future<void> _showAlertTextFieldEmpty(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Correo No Valido',
            textAlign: TextAlign.center,
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text(
                  'Favor de ingresar el correo con el que inicio sesion',
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
