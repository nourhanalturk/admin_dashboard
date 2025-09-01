import '../../../../config/constants/supabase_fields_constants.dart';

class PatientMedicalRecordsModel {
  String? diseaseName;
  String? description;
  String? doctorName;
  dynamic? reportDate;
  String? medicineNames;
  List<dynamic>? imageUrls;
  String? recordFor;

  PatientMedicalRecordsModel({
    this.diseaseName,
    this.description,
    this.doctorName,
    this.reportDate,
    this.medicineNames,
    this.imageUrls,
    this.recordFor,
  });

  factory PatientMedicalRecordsModel.fromJson(Map<String, dynamic> json) {
    return PatientMedicalRecordsModel(
      diseaseName: json[SupabaseFieldsConstants.diseaseName],
      description: json[SupabaseFieldsConstants.description],
      doctorName: json[SupabaseFieldsConstants.doctorName],
      reportDate: json[SupabaseFieldsConstants.reportDate],
      medicineNames: json[SupabaseFieldsConstants.medicineNames],
      imageUrls: json[SupabaseFieldsConstants.imageUrls],
      recordFor: json[SupabaseFieldsConstants.recordFor],
    );
  }


}