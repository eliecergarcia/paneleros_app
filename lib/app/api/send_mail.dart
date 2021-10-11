import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class SendEmail {
  String userName = 'masivos@agrogestion.com.co';
  String password = '1020304045-1';

  Future<bool> sendEmail(String emailRecipients, String passwordUpdate) async {
    final smtpServer = SmtpServer('mail.agrogestion.com.co',
        port: 465,
        ssl: true,
        ignoreBadCertificate: false,
        allowInsecure: false,
        username: userName,
        password: password);
    final message = Message()
      ..from = Address(userName, 'La Voz de los Paneleros')
      ..recipients.add(emailRecipients)
      ..subject = 'Solicitud de Contraseña ${DateTime.now()}'
      ..text =
          'Hola Solicitaste el cambio de contraseña temporal!\n la voz de los Paneleros te mandan tu contraseña temporal que es la siguiente: ' +
              passwordUpdate +
              '\n' +
              'De ante mano te damos las gracias! y en cuanto entres a la aplicación se te solicitara volver actualizar la contraseña';
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
