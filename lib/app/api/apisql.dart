import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiConnect {
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
  Future<bool> login(String email, String password) async {
    var url = 'https://www.agrogestion.com.co/app/flutter/login.php';
    final response = await http.post(Uri.parse(url), body: {
      "email": email.toString(),
      "password": password.toString(),
    });
    var responseInfo = json.decode(response.body);

    if (responseInfo.toString().length > 3) {
      if (responseInfo[0]['password'] == password.toString() &&
          responseInfo[0]['Correo'] == email.toString()) {
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
      if (responseInfo[0]['password'] == password.toString() &&
          responseInfo[0]['Correo'] == email.toString()) {
        return true;
      } else {
        return false;
      }
    } else {
      print('false');
      return false;
    }
  }
}
