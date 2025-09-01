import 'package:tender/config/constants/supabase_fields_constants.dart';

class AvailableTimesModel {
  DateTime availableDate;
  List<String> availableTimes;

  AvailableTimesModel({
    required this.availableDate,
    required this.availableTimes,
  });

  AvailableTimesModel.fromJson(Map<String, dynamic> json)
      : availableDate = DateTime.parse(
            json[SupabaseFieldsConstants.availableDate] as String),
        availableTimes = List<String>.from(
            json[SupabaseFieldsConstants.availableTime] as List<dynamic>);
}
