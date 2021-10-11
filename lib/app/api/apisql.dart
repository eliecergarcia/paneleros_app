import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:paneleros_app/app/api/send_mail.dart';
import 'package:paneleros_app/app/pages/recoverpassword_page.dart';

class ApiConnect extends SendEmail {
  ///Funcion para dar de alta usuarios
  Future<bool> createUser(
      String firstName,
      String secondName,
      String firstLastName,
      String secondLastName,
      String email,
      String password,
      String apartment,
      int cellphone,
      String useInfo,
      String city) async {
    var url = 'https://www.agrogestion.com.co/app/flutter/registro.php';
    var response = await http.post(Uri.parse(url), body: {
      'Nombre': firstName.toString(),
      'SegundoNombre': secondName.toString(),
      'ApellidoPaterno': firstLastName.toString(),
      'ApellidoMaterno': secondLastName.toString(),
      'Celular': cellphone.toString(),
      'Correo': email.toString(),
      'Departamento': apartment.toString(),
      'Municipio': city,
      'Password': password,
      'usaDatos': useInfo,
      'CambioContrasena': 'No',
    });
    var responseInfo = json.decode(response.body);
    print(responseInfo);
    if (responseInfo.toString() == 'el correo ya existe') {
      return false;
    } else {
      if (responseInfo.toString().length > 3) {
        return true;
      } else {
        return false;
      }
    }
  }

  ///Funcion para inciar sesion
  Future<bool> login(
      String email, String password, BuildContext context) async {
    var url = 'https://www.agrogestion.com.co/app/flutter/login.php';
    final response = await http.post(Uri.parse(url), body: {
      "email": email.toString(),
      "password": password.toString(),
    });
    var responseInfo = json.decode(response.body);

    if (responseInfo.toString().length > 3) {
      if (responseInfo[0]['password'] == password.toString() &&
          responseInfo[0]['Correo'] == email.toString()) {
        if (responseInfo[0]['CambioContrasena'] == '1') {
          var urlPassword =
              "https://www.agrogestion.com.co/app/flutter/recoverEmail.php";
          final responsePassword =
              await http.post(Uri.parse(urlPassword), body: {
            'email': email,
            'password': password,
            'changePassword': '0',
          }).then(
            (_) => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RecoverPasswordPage(),
              ),
            ),
          );
          return true;
        }
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  ///Funcion para recuperar la contrasena
  Future<bool> recoverPassword(String email, String password) async {
    var url = 'https://www.agrogestion.com.co/app/flutter/recoverPassword.php';
    final response = await http.post(Uri.parse(url), body: {
      'email': email,
      'password': password,
    });
    var responseInfo = json.decode(response.body);
    print(responseInfo);
    if (responseInfo.toString().length > 3) {
      if (responseInfo[0]['Correo'] == email.toString()) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  //Funcion para soliticar actualizar la contrasena
  Future<bool> updatePassword(String email, int changePassword) async {
    var url = "https://www.agrogestion.com.co/app/flutter/recoverEmail.php";
    bool sendMail = false;
    Random random = new Random();
    int randomNumber = random.nextInt(100);
    String passwordUpdate = 'Paneleros' + randomNumber.toString();
    final response = await http.post(Uri.parse(url), body: {
      'email': email,
      'password': passwordUpdate,
      'changePassword': changePassword.toString(),
    });
    var responseInfo = jsonDecode(response.body);
    print(responseInfo);
    if (response.toString().length > 3) {
      sendMail = await sendEmail(email, passwordUpdate);
      if (sendMail) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }
}
