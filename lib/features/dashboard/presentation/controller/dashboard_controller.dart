import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tender/config/constants/supabase_fields_constants.dart';
import 'package:tender/config/constants/supabase_tables_constants.dart';
import 'package:tender/config/di/di.dart';
import 'package:tender/core/resources/manager_images.dart';
import 'package:tender/features/dashboard/domain/model/tab_model.dart';

import '../../../../core/resources/manager_strings.dart';
import '../../domain/model/upcoming_patinet_appointment_model.dart';

class DashboardController extends GetxController {
  int selectedTabIndex = 0;
  bool isSidebarOpen = false;
  List<TabModel> tabs = [
    TabModel(
      icon: ManagerImages.home,
      title: ManagerStrings.home,
    ),
    TabModel(
      icon: ManagerImages.chat,
      title: ManagerStrings.chat,
    ),
    TabModel(
      icon: ManagerImages.appointment,
      title: ManagerStrings.viewAppointments,
    ),
    TabModel(
      icon: ManagerImages.clock,
      title: ManagerStrings.availableTimes,
    ),
    TabModel(
      icon: ManagerImages.data,
      title: ManagerStrings.patientsData,
    ),
  ];

  void changeTabIndex(int index) {
    selectedTabIndex = index;
    update();
  }

  void toggleSidebar() {
    isSidebarOpen = !isSidebarOpen;
    update();
  }

  void closeSidebar() {
    isSidebarOpen = false;
    update();
  }

  var totalPatients = 0;
  var totalPatientsWithAppointments = 0;
  int totalPatientsWithUpcomingAppointments = 0;
  int totalPatientsWithMessages = 0;

  getTotalPatientsWithAppointments() async {
    var response = await supabase.from(SupabaseTableConstants.patients).select(
        SupabaseFieldsConstants.patientId,
        const FetchOptions(count: CountOption.exact));

    totalPatients = response.count ?? 0;

    const doctorId = 2;
    response = await Supabase.instance.client
        .from(SupabaseTableConstants.appointments)
        .select(
      SupabaseFieldsConstants.patientId,
    )
        .eq(SupabaseFieldsConstants.doctorId, doctorId);

    final allAppointment = response as List;
    final uniquePatientIds = allAppointment
        .map(
          (e) => e[SupabaseFieldsConstants.patientId],
    )
        .toSet()
        .toList();

    totalPatientsWithAppointments = uniquePatientIds.length ?? 0;


    update();
  }

  getTotalPatientsWithUpcomingAppointments(int doctorId) async {
    final response = await supabase.from(SupabaseTableConstants.appointments)
        .select(SupabaseFieldsConstants.patientId)
        .eq(SupabaseFieldsConstants.doctorId, doctorId).gt(SupabaseFieldsConstants.appointmentTime, DateTime.now());
    final uniquePatientIds = response.map((e) => e[SupabaseFieldsConstants.patientId]).toSet();

    totalPatientsWithUpcomingAppointments = uniquePatientIds.length;
    update();
  }

  getTotalPatientsWithMessages(int doctorId)async{
    final response = await supabase.from(SupabaseTableConstants.allChats)
        .select(SupabaseFieldsConstants.patientId)
        .eq(SupabaseFieldsConstants.doctorId, doctorId);
    final uniquePatientIds = response.map((e) => e[SupabaseFieldsConstants.patientId]).toSet();

    totalPatientsWithMessages = response.length;
    print(totalPatientsWithMessages);
    update();
  }

  patientAppointment() async {
    // SELECT COUNT(DISTINCT patient_id) AS patients_with_upcoming_appointments
    // FROM appointments
    // WHERE appointment_time > NOW()
    // AND doctor_id = :doctor_id;
  }

  List<UpcomingPatientAppointmentModel> upcomingAppointments = [];
  bool isUpcomingAppointmentsLoading = false;

  Future<void> fetchUpcomingAppointments(int doctorId) async {
    isUpcomingAppointmentsLoading = true;
    update();
    final response = await supabase
        .from(SupabaseTableConstants.appointments)
        .select(
        'patient_id, appointment_time, dependent_name, dependent_image_url')
        .gt('appointment_time', DateTime.now().toIso8601String())
        .eq('doctor_id', doctorId)
        .order('appointment_time', ascending: true)
        .then(
          (value) {
        final allAppointments = value as List;

        final Map<String, UpcomingPatientAppointmentModel> uniquePatients = {};

        for (var item in allAppointments) {
          final patientId = item['patient_id'];
          if (!uniquePatients.containsKey(patientId)) {
            uniquePatients[patientId] =
                UpcomingPatientAppointmentModel.fromJson(item);
          }
          if (uniquePatients.length >= 3) break;
        }

        upcomingAppointments = uniquePatients.values.toList();

        isUpcomingAppointmentsLoading = false;
        update();
      },
    ).catchError((e) {
      isUpcomingAppointmentsLoading = false;
      update();
    });


    print('Upcoming unique appointments: ${upcomingAppointments.length}');
    update();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void onInit() {
    getTotalPatientsWithAppointments();
    getTotalPatientsWithUpcomingAppointments(2);
    fetchUpcomingAppointments(2);
    getTotalPatientsWithMessages(2);
    super.onInit();
  }
}
