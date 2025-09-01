import 'package:get/get.dart';
import 'package:tender/config/constants/supabase_fields_constants.dart';
import 'package:tender/config/constants/supabase_tables_constants.dart';
import '../../../../config/di/di.dart';
import '../../domain/model/appointment_model.dart';

class AppointmentController extends GetxController {
  List<Appointment> appointments = [];
  bool isLoading = true;

  @override
  void onInit() {
    super.onInit();
    fetchAppointments(2);
  }

  void fetchAppointments(int doctorId) async {
    try {
      isLoading = true;
      update();

      final response = await supabase
          .from(SupabaseTableConstants.appointments)
          .select()
          .eq(SupabaseFieldsConstants.doctorId, doctorId)
          .order(SupabaseFieldsConstants.appointmentTime, ascending: true)
          .execute();

      final data = response.data as List<dynamic>;
      appointments = data.map((e) => Appointment.fromJson(e)).toList();
    } catch (e) {
      print('Error fetching appointments: $e');
      appointments = [];
    } finally {
      isLoading = false;
      update();
    }
  }
}
