import 'package:get/get.dart';
import 'package:tender/config/constants/supabase_fields_constants.dart';
import 'package:tender/config/constants/supabase_tables_constants.dart';
import 'package:tender/config/di/di.dart';
import 'package:tender/features/patients_details/domain/model/patient_medical_records_model.dart';
import 'package:tender/features/patients_details/domain/model/patients_details_model.dart';

class PatientsDetailsController extends GetxController {
  List<String> patientsIds = [];
  List<PatientDetailsModel> patientsDetails = [];
  List<PatientMedicalRecordsModel> patientMedicalRecords = [];

  getDoctorPatients() async {
    const doctorId = 2;
    await supabase
        .from(SupabaseTableConstants.appointments)
        .select(SupabaseFieldsConstants.patientId)
        .eq(SupabaseFieldsConstants.doctorId, doctorId)
        .then(
      (value) {
        patientsIds = List<String>.from(value
                .map((e) => e[SupabaseFieldsConstants.patientId] as String))
            .toSet()
            .toList();
        update();
        getPatientsDetails(patientsIds);
      },
    ).catchError((e) {
      Get.snackbar('Error', e.toString());
    });
  }

  getPatientsDetails(List<String> ids) async {
    for (var patientId in ids) {
      await supabase
          .from(SupabaseTableConstants.patients)
          .select()
          .eq(SupabaseFieldsConstants.patientId, patientId)
          .then(
        (value) {
          final patient = List<PatientDetailsModel>.from(
              value.map((e) => PatientDetailsModel.fromJson(e)));
          patientsDetails.addAll(patient);
          update();
        },
      ).catchError((e) {
        Get.snackbar('Error', e.toString());
      });
    }

    return patientsDetails;
  }

  getPatientMedicalRecords(String patientId) async {
    await supabase
        .from(SupabaseTableConstants.medicalRecords)
        .select()
        .eq(SupabaseFieldsConstants.patientId, patientId)
        .then((value) {
      patientMedicalRecords = List<PatientMedicalRecordsModel>.from(
          value.map((e) => PatientMedicalRecordsModel.fromJson(e)));
      update();
    }).catchError((e) {
      Get.snackbar('Error', e.toString());
    });
  }

  @override
  void onInit() {
    getDoctorPatients();
    super.onInit();
  }
}
