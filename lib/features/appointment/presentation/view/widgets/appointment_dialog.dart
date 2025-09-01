import 'package:flutter/material.dart';
import 'package:tender/core/extensions/extensions.dart';
import 'package:tender/features/appointment/presentation/controller/appointment_controller.dart';

import '../../../../../core/resources/manager_strings.dart';
import '../../../domain/model/appointment_model.dart';

class AppointmentDetailDialog extends StatelessWidget {
  final Appointment appointment;
  final AppointmentController controller;

  const AppointmentDetailDialog({
    super.key,
    required this.appointment,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 10,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage(appointment.dependentImageUrl.onNullImage()),
            ),
            const SizedBox(height: 10),
            Text(
              appointment.dependentName.onNull(),
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            Text('${ManagerStrings.contactNumber}: ${appointment.contactNumber}'),
            const SizedBox(height: 5),
            Text('${ManagerStrings.status}: ${appointment.status}'),
            const SizedBox(height: 5),
            Text('${ManagerStrings.appointmentTime}: ${appointment.appointmentTime.toLocal()}'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: Text(ManagerStrings.settings),
            ),
          ],
        ),
      ),
    );
  }
}
