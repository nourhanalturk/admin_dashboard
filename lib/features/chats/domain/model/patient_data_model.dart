import 'package:tender/config/constants/supabase_fields_constants.dart';

class PatientDataModel {
  String? patientId;
  String? fullName;
  String? contactNumber;
  String? image;

  PatientDataModel({
    required this.patientId,
    required this.fullName,
    required this.contactNumber,
    required this.image,
  });

  factory PatientDataModel.fromJson(Map<String, dynamic> json) {
    return PatientDataModel(
      patientId: json[SupabaseFieldsConstants.patientId],
      fullName: json[SupabaseFieldsConstants.fullName],
      contactNumber: json[SupabaseFieldsConstants.contactNumber],
      image: json[SupabaseFieldsConstants.profileImageUrl],
    );
  }
}
