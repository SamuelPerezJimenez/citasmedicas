import 'package:citas_medicas_app/models/appointment_model.dart' as cita;
import 'package:citas_medicas_app/models/appointment_status_model.dart';
import 'package:citas_medicas_app/models/appointment_type_model.dart';
import 'package:citas_medicas_app/models/ars.dart';
import 'package:citas_medicas_app/models/disponibilidad_model.dart';
import 'package:citas_medicas_app/models/doctors.dart' as doctorModel;
import 'package:citas_medicas_app/models/specialities.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

import '../models/doctors.dart';
import '../models/patients.dart';

final DateFormat formatGlobal = DateFormat('yyyy-MM-dd HH:mm');

class WebService {
  var dio = Dio(BaseOptions(baseUrl: 'http://localhost:5001/api/dev/'));

  Future<List<doctorModel.Doctor>> getDoctors(
      {String idDoctor = '', String name = '', int speciality = 0}) async {
    Response response;

    response = await dio.get('doctores/',
        queryParameters: {'id': idDoctor, 'idespecialidad': speciality});

    var result = MessageResponse.fromJson(response.data);

    return result.doctor;
  }

  Future<List<cita.Cita>> getAppointments(
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

    var result = cita.AppointmentResponse.fromJson(response.data);

    return result.citas;
  }

  Future<List<Especialidad>> getSpecialities({bool allValue = true}) async {
    Response response;

    response = await dio.get('especialidad/', queryParameters: {'id': 12});

    var result = SpecialtiesResponse.fromJson(response.data);
    if (allValue) {
      result.especialidad.add(Especialidad(cod: 0, descripcion: 'Todas'));
    }

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

  Future<String> saveAppointment(
      {fecha,
      montoConsulta,
      nota,
      fechaCreacion,
      codPaciente,
      codDoctor,
      codTipoCita,
      codEstado}) async {
    Response response;

    response = await dio.get('citasIngresar/', queryParameters: {
      'fecha': formatGlobal.format(fecha),
      'monto_consulta': 1500,
      'nota': 'NOTA',
      'fecha_creacion': formatGlobal.format(DateTime.now()),
      'cod_paciente': codPaciente,
      'cod_doctor': codDoctor,
      'cod_tipo_cita': codTipoCita,
      'cod_estado': codEstado
    });

    return 'OK';
  }

  Future<String> savePatient(
      {codPersona,
      nombre,
      apellido,
      correo,
      id_ars,
      num_afiliado,
      telefono}) async {
    Response response;

    response = await dio.get('pacientesIngresar/', queryParameters: {
      'cod_persona': codPersona,
      'nombre': nombre,
      'apellido': apellido,
      'correo': correo,
      'id_ars': id_ars,
      'num_afiliado': num_afiliado,
      'telefono': telefono,
    });

    return 'OK';
  }

  Future<List<EstadoCita>> getAppointmentStatus({String id = ''}) async {
    Response response;

    response = await dio.get('estado/', queryParameters: {'id': id});

    var result = AppointmentStatusResponse.fromJson(response.data);

    result.estadoCita.add(EstadoCita(cod: 0, descripcion: 'Todas'));

    result.estadoCita.sort(((a, b) => a.cod.compareTo(b.cod)));

    return result.estadoCita;
  }

  Future<DisponibilidadResponse> getDisponibilidad(
      {String id = '', String name = ''}) async {
    Response response;

    response = await dio
        .get('disponibles/', queryParameters: {'id': id, 'nombre': name});

    var result = DisponibilidadResponse.fromJson(response.data);

    return result;
  }

  Future<List<Ar>> getArs({String id = '', String name = ''}) async {
    Response response;

    response =
        await dio.get('ars/', queryParameters: {'id': id, 'nombre': name});

    var result = ArsResponse.fromJson(response.data);

    return result.ars;
  }
}
