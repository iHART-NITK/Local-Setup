import 'dart:convert' as convert;

import '/core/network/django_app.dart';

class GetPrescriptionAppointments {
  Future<List<dynamic>> getData() async {
    final _response =
        await DjangoApp().get('/appointment/', userSpecific: true);

    List<dynamic> decodedResponse =
        convert.jsonDecode(_response.body) as List<dynamic>;

    return decodedResponse;
  }
}
