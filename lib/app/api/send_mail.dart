import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class SendEmail {
  String userName = 'masivos@agrogestion.com.co';
  String password = '1020304045-1';

  Future<bool> sendEmail(String emailRecipients,String passwordUpdate) async {
    final smtpServer = SmtpServer(userName, password: password);

    final message = Message()
      ..from = Address(userName, 'La Voz de los Panaleros')
      ..recipients.add('absalonsubzero@gmail.com')
      ..subject = 'Solicitud de Contraseña ${DateTime.now()}'
      ..text =
          'Hola! la voz de los panaleros te mandan tu contraseña temporal que es la siguiente: ' +
              passwordUpdate +
              '\n' +
              'De ante mano te damo las gracias! y en cuanto entres a la aplicación se te solicitara volver actualizar la contraseña';
      // ..html = '';
    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
      return true;
    } on MailerException catch (e) {
      print('Message not sent.');
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
      return false;
    }
  }
}
