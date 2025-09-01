import 'package:tender/config/constants/supabase_fields_constants.dart';

class PatientDetailsModel {
  String fullName ;
  String contactNumber ;
  String profileImage ;

  PatientDetailsModel({
    required this.fullName,
    required this.contactNumber,
    required this.profileImage,
  });

  factory PatientDetailsModel.fromJson(Map<String, dynamic> json) {
    return PatientDetailsModel(
      fullName: json[SupabaseFieldsConstants.fullName] ?? '',
      contactNumber: json[SupabaseFieldsConstants.contactNumber] ?? '',
      profileImage: json[SupabaseFieldsConstants.profileImageUrl] ?? '',
    );
  }
}