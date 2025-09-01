import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tender/core/resources/manager_colors.dart';
import 'package:tender/core/resources/manager_font_size.dart';
import 'package:tender/core/resources/manager_strings.dart';
import 'package:tender/core/resources/manager_styles.dart';
import 'package:tender/core/resources/manager_height.dart';
import 'package:tender/core/resources/manager_radius.dart';
import 'package:tender/features/patients_details/presentation/controller/patients_details_controller.dart';
import 'package:tender/features/patients_details/presentation/view/widgets/patient_records_dialog.dart';

import '../../../../core/widgets/responsive.dart';

class PatientsDetailsView extends StatelessWidget {
  const PatientsDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PatientsDetailsController>(
      builder: (controller) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ManagerStrings.patientsDetails,
                  style: getBoldTextStyle(
                    fontSize: ManagerFontSize.s24,
                    color: ManagerColors.black,
                  ),
                ),
                SizedBox(height: ManagerHeight.h10),
                Text(
                  ManagerStrings.hereWhereAllYourPatientsDetailsWillBeDisplayed,
                  style: getMediumTextStyle(
                    fontSize: ManagerFontSize.s19,
                    color: ManagerColors.grayColor,
                  ),
                ),
                SizedBox(height: ManagerHeight.h20,),

                if (controller.patientsDetails.isEmpty)
                  Expanded(
                    child: Center(
                      child: Text(
                        ManagerStrings.hereWhereAllYourPatientsDetailsWillBeDisplayed,
                        style: getMediumTextStyle(
                          fontSize: ManagerFontSize.s18,
                          color: ManagerColors.grayColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                else
                  Expanded(
                    child: Responsive(
                      mobile: _buildPatientsGrid(controller, crossAxisCount: 1),
                      tablet: _buildPatientsGrid(controller, crossAxisCount: 2),
                      desktop: _buildPatientsGrid(controller, crossAxisCount: 3),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildPatientsGrid(PatientsDetailsController controller,
      {required int crossAxisCount}) {
    return GridView.builder(
      itemCount: controller.patientsDetails.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1.1,
      ),
      itemBuilder: (context, index) {
        final patient = controller.patientsDetails[index];
        return GestureDetector(
          onTap: () {
            controller.getPatientMedicalRecords(controller.patientsIds[index]);
            showDialog(
              context: context,
              builder: (_) => PatientRecordsDialog(
                patientName: patient.fullName,
                patientId: controller.patientsIds[index],
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: ManagerColors.white,
              borderRadius: BorderRadius.circular(ManagerRadius.r16),
              boxShadow: [
                BoxShadow(
                  color: ManagerColors.grayColor.withOpacity(0.2),
                  blurRadius: 8,
                  offset: const Offset(2, 4),
                ),
              ],
            ),
            padding: const EdgeInsets.all(12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(patient.profileImage),
                  backgroundColor: ManagerColors.grayColor.withOpacity(0.3),
                ),
                const SizedBox(height: 12),
                Text(
                  patient.fullName,
                  style: getBoldTextStyle(
                    fontSize: ManagerFontSize.s16,
                    color: ManagerColors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: Text(
                    "${ManagerStrings.contactNumber}: ${patient.contactNumber}",
                    style: getMediumTextStyle(
                      fontSize: ManagerFontSize.s14,
                      color: ManagerColors.grayColor,
                    ),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
