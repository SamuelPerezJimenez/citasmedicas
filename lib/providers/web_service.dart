import 'package:citas_medicas_app/models/appointment_model.dart';
import 'package:citas_medicas_app/models/appointment_status_model.dart';
import 'package:citas_medicas_app/models/appointment_type_model.dart';
import 'package:citas_medicas_app/models/doctors.dart' as doctorModel;
import 'package:citas_medicas_app/models/specialities.dart';
import 'package:dio/dio.dart';

import '../models/doctors.dart';
import '../models/patients.dart';

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

  Future<List<Cita>> getAppointments(
      {String idAppointment = '',
      int idAppointmentType = 0,
      int idAppointmentStatus = 0,
      String date = ''}) async {
    Response response;

    response = await dio.get('citas/', queryParameters: {
      'id': idAppointment,
      'idTipoCita': idAppointmentType,
      'idEstado': idAppointmentStatus,
      'fecha': date
    });

    var result = AppointmentResponse.fromJson(response.data);

    return result.citas;
  }

  Future<List<Especialidad>> getSpecialities() async {
    Response response;

    response = await dio.get('especialidad/', queryParameters: {'id': 12});

    var result = SpecialtiesResponse.fromJson(response.data);
    result.especialidad.add(Especialidad(cod: 0, descripcion: 'Todas'));

    result.especialidad.sort(((a, b) => a.cod.compareTo(b.cod)));

    return result.especialidad;
  }

  Future<List<Paciente>> getPatients(
      {String idPaciente = '', int idArs = 0}) async {
    Response response;

    response = await dio
        .get('pacientes/', queryParameters: {'id': idPaciente, 'idars': idArs});

    var result = PatientsResponse.fromJson(response.data);

    return result.paciente;
  }

  Future<List<TipoCita>> getAppointmentType({String id = ''}) async {
    Response response;

    response = await dio.get('tipoCita/', queryParameters: {'id': id});

    var result = AppointmentTypeResponse.fromJson(response.data);
    result.tipoCita.add(TipoCita(cod: 0, descripcion: 'Todas'));

    result.tipoCita.sort(((a, b) => a.cod.compareTo(b.cod)));

    return result.tipoCita;
  }

  Future<List<EstadoCita>> getAppointmentStatus({String id = ''}) async {
    Response response;

    response = await dio.get('estado/', queryParameters: {'id': id});

    var result = AppointmentStatusResponse.fromJson(response.data);

    result.estadoCita.add(EstadoCita(cod: 0, descripcion: 'Todas'));

    result.estadoCita.sort(((a, b) => a.cod.compareTo(b.cod)));

    return result.estadoCita;
  }
}
