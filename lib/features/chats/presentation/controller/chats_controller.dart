import 'package:get/get.dart';
import 'package:tender/config/constants/supabase_fields_constants.dart';
import 'package:tender/config/constants/supabase_tables_constants.dart';
import 'package:tender/config/di/di.dart';
import 'package:tender/core/cache/app_cache.dart';
import '../../../../core/routes/routes.dart';
import '../../domain/model/chat_model.dart';
import '../../domain/model/chat_with_patient_model.dart';
import '../../domain/model/patient_data_model.dart';

class ChatsController extends GetxController {
  List<ChatModel> allChats = [];
  List<PatientDataModel> patientsData = [];
  List<String> patientIds = [];
  List<ChatWithPatient> combinedChats = [];

  bool isLoading = true;

  getChats() async {
    // final doctorId = supabase.auth.currentUser!.id; // هذا هو الدكتور الحالي
    final doctorId = 2;
    await supabase
        .from('all_chats')
        .select()
        .eq(SupabaseFieldsConstants.doctorId, doctorId)
        .order(SupabaseFieldsConstants.updatedAt, ascending: false)
        .then((value) {
      allChats = (value as List)
          .map((e) => ChatModel.fromJson(e as Map<String, dynamic>))
          .toList();

      patientIds = allChats.map((chat) => chat.patientId!).toSet().toList();

      getPatientsDetails(patientIds);
    }).catchError((e) {
      print("Error fetching chats: $e");
    });
  }

  getPatientsDetails(List<String> ids) async {
    isLoading = true;
    update();

    if (ids.isEmpty) return;

    final response = await supabase
        .from(SupabaseTableConstants.patients)
        .select()
        .filter(
          SupabaseFieldsConstants.patientId,
          'in',
          '(${ids.map((id) => "\"$id\"").join(",")})',
        );

    patientsData = (response as List)
        .map((e) => PatientDataModel.fromJson(e as Map<String, dynamic>))
        .toList();
    combinedChats = [];
    for (var chat in allChats) {
      final patient = patientsData.firstWhere(
        (p) => p.patientId == chat.patientId,
      );
      combinedChats.add(ChatWithPatient(chat: chat, patient: patient));
    }

    isLoading = false;
    update();
  }

  navigateToMessages(String chatUid, String patientName) {
    CacheData.setPatientName(patientName);
    CacheData.setChatUid(chatUid);
    Get.toNamed(Routes.messages);
  }

  @override
  void onInit() {
    getChats();
    super.onInit();
  }
}
