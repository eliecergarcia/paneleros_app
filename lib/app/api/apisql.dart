import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiConnect {
  String idUser;

  ///Funcion para dar de alta usuarios
  Future<void> createUser(
      String firstName,
      String secondName,
      String firstLastName,
      String secondLastName,
      String email,
      String password,
      String apartment,
      int cellphone,
      int useInfo) async {
    firstName = 'eliecer';
    secondName = '';
    firstLastName = 'Garcia';
    secondLastName = '';
    cellphone = 3333333;
    email = 'absalonsubzero@gmail.com';
    apartment = 'isla casiopea';
    password = '15';

    var url = 'http://192.168.1.143/regClientes/registro.php';
    var response = await http.post(Uri.parse(url), body: {
      'Nombre': firstName.toString(),
      'Nombre2': secondName.toString(),
      'Apellido': firstLastName.toString(),
      'Apellido2': secondLastName.toString(),
      'Celular': cellphone.toString(),
      'Correo': email.toString(),
      'Departamento': apartment.toString(),
      'Municipio': '',
      'password': password.toString(),
      'usarDatos': 1.toString(),
    });
    print('${response.statusCode}');
  }

  ///Funcion para inciar sesion
  Future<bool> login(String email, String password) async {
    var url = 'http://192.168.1.143/regClientes/login.php';
    final response = await http.post(Uri.parse(url), body: {
      "email": email.toString(),
      "password": password.toString(),
    });
    var responseInfo = json.decode(response.body);
    if (responseInfo != null) {
      if (responseInfo[0]['password'] == password.toString() &&
          responseInfo[0]['Correo'] == email.toString()) {
        return true;
      }
    }
    return false;
  }

  ///Funcion para recuperar la contrasena
  Future<bool> recoverPassword(String email) async {
    var url = 'http://192.168.1.143/regClientes/QueryEmail.php';
    final response = await http.post(Uri.parse(url), body: {
      'email': email,
    });
    var responseInfo = json.decode(response.body);
    if (responseInfo != null) {
      if (responseInfo[0]['RegClienteID'] != null) {
        idUser = responseInfo[0]['RegClienteID'].toString();
        print("$idUser");
        return true;
      }
    } else {
      return false;
    }
    return false;
  }
}
