class UpcomingPatientAppointmentModel {
  final String patientId;
  final String appointmentTime;
  final String dependentName;
  final String dependentImageUrl;

  UpcomingPatientAppointmentModel({
    required this.patientId,
    required this.appointmentTime,
    required this.dependentName,
    required this.dependentImageUrl,
  });

  factory UpcomingPatientAppointmentModel.fromJson(Map<String, dynamic> json) {
    return UpcomingPatientAppointmentModel(
      patientId: json['patient_id'],
      appointmentTime: json['appointment_time'],
      dependentName: json['dependent_name'] ?? '',
      dependentImageUrl: json['dependent_image_url'] ?? '',
    );
  }
}
