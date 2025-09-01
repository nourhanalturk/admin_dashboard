import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tender/core/extensions/extensions.dart';
import 'package:tender/features/appointment/presentation/controller/appointment_controller.dart';
import 'package:tender/features/appointment/presentation/view/widgets/appointment_dialog.dart';
import '../../../../core/resources/manager_strings.dart';

class AppointmentsView extends StatelessWidget {
  const AppointmentsView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppointmentController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              ManagerStrings.appointments,
            ),
          ),
          body: controller.isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : controller.appointments.isEmpty
                  ? Center(
                      child: Text(
                        ManagerStrings.noUpcomingAppointmentsYet,
                      ),
                    )
                  : ListView.builder(
                      itemCount: controller.appointments.length,
                      itemBuilder: (context, index) {
                        final appt = controller.appointments[index];
                        return GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (_) => AppointmentDetailDialog(
                                appointment: appt,
                                controller: controller,
                              ),
                            );
                          },
                          child: Card(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            elevation: 5,
                            child: ListTile(
                              leading: CircleAvatar(
                                radius: 28,
                                backgroundImage: NetworkImage(
                                    appt.dependentImageUrl.onNullImage()),
                              ),
                              title: Text(appt.dependentName.onNull(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                              subtitle: Text(
                                  '${appt.contactNumber}\n${appt.appointmentTime.toLocal()}'),
                              trailing: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: Colors.blueAccent.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  appt.status.onNull(),
                                  style: const TextStyle(
                                    color: Colors.blueAccent,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
        );
      },
    );
  }
}
