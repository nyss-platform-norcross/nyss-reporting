import 'package:flutter_sms/flutter_sms.dart';

class SMSUtility {
  static void sendSMS(String message, List<String> recipents) async {
    String _result =
        await FlutterSms.sendSMS(message: message, recipients: recipents)
            .catchError((onError) {
      print(onError);
    });
    print(_result);
  }
}
