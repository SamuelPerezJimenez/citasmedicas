import 'package:citas_medicas_app/models/doctors.dart' as doctorModel;
import 'package:citas_medicas_app/models/specialities.dart';
import 'package:dio/dio.dart';

import '../models/doctors.dart';

class WebService {
  var dio = Dio(BaseOptions(baseUrl: 'http://localhost:5001/api/dev/'));

  Future<List<doctorModel.Doctor>> getDoctors(
      {String idDoctor = '', int speciality = 0}) async {
    Response response;

    response = await dio.get('doctores/',
        queryParameters: {'id': idDoctor, 'idespecialidad': speciality});

    var result = MessageResponse.fromJson(response.data);

    return result.doctor;
  }

  Future<List<Especialidad>> getSpecialities() async {
    Response response;

    response = await dio.get('especialidad/', queryParameters: {'id': 12});

    var result = SpecialtiesResponse.fromJson(response.data);
    result.especialidad.add(Especialidad(cod: 0, descripcion: 'Todas'));

    result.especialidad.sort(((a, b) => a.cod.compareTo(b.cod)));

    return result.especialidad;
  }
}
