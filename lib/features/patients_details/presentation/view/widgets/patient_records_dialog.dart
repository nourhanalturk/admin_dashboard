import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tender/core/extensions/extensions.dart';
import 'package:tender/core/resources/manager_colors.dart';
import 'package:tender/core/resources/manager_font_size.dart';
import 'package:tender/core/resources/manager_opacity.dart';
import 'package:tender/core/resources/manager_radius.dart';
import 'package:tender/core/resources/manager_strings.dart';
import 'package:tender/core/resources/manager_styles.dart';
import 'package:tender/core/resources/manager_width.dart';
import 'package:tender/features/patients_details/presentation/controller/patients_details_controller.dart';

class PatientRecordsDialog extends StatelessWidget {
  final String patientName;
  final String patientId;

  const PatientRecordsDialog({
    super.key,
    required this.patientName,
    required this.patientId,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          ManagerRadius.r16,
        ),
      ),
      child: GetBuilder<PatientsDetailsController>(
        builder: (controller) {
          final records = controller.patientMedicalRecords;

          return Container(
            width: MediaQuery.of(context).size.width * ManagerOpacity.op0_6,
            padding: EdgeInsets.all(
              ManagerWidth.w15,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "${ManagerStrings.medicalRecords} - $patientName",
                  style: TextStyle(
                    fontSize: ManagerFontSize.s18,
                    fontWeight: FontWeight.bold,
                    color: ManagerColors.black,
                  ),
                ),
                SizedBox(
                  height: ManagerWidth.w15,
                ),
                records.isEmpty
                    ? Text(
                        ManagerStrings.noRecordsFound,
                        style: getBoldTextStyle(
                          fontSize: ManagerFontSize.s16,
                          color: ManagerColors.grey,
                        ),
                      )
                    : ListView.separated(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemCount: records.length,
                        separatorBuilder: (_, __) => const Divider(
                          color: ManagerColors.lightGrey,
                        ),
                        itemBuilder: (context, index) {
                          final record = records[index];
                          return ListTile(
                            leading: const Icon(
                              Icons.folder_open,
                              color: ManagerColors.primaryColor,
                            ),
                            title: Text(
                              record.diseaseName.onNull(),
                              style: getBoldTextStyle(
                                fontSize: ManagerFontSize.s16,
                                color: ManagerColors.black,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(record.description ?? ''),
                                Text(
                                    "By: ${record.doctorName ?? ''} | ${record.reportDate ?? ''}"),
                                if (record.medicineNames != null)
                                  Text("Medicines: ${record.medicineNames}"),
                              ],
                            ),
                          );
                        },
                      ),
              ],
            ),
          );
        },
      ),
    );
  }
}
