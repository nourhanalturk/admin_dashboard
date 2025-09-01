class Appointment {
  final String appointmentId;
  final int doctorId;
  final String patientId;
  final DateTime appointmentTime;
  final String? status;
  final String? dependentName;
  final String? contactNumber;
  final String? dependentImageUrl;
  final DateTime createdAt;

  Appointment({
    required this.appointmentId,
    required this.doctorId,
    required this.patientId,
    required this.appointmentTime,
    required this.status,
    required this.dependentName,
    required this.contactNumber,
    required this.dependentImageUrl,
    required this.createdAt,
  });

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      appointmentId: json['appointment_id'],
      doctorId: json['doctor_id'],
      patientId: json['patient_id'],
      appointmentTime: DateTime.parse(json['appointment_time']),
      status: json['status']?? 'pending',
      dependentName: json['dependent_name'],
      contactNumber: json['contact_number'],
      dependentImageUrl: json['dependent_image_url'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}
