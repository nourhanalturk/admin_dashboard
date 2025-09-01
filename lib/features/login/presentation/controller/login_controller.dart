import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tender/config/di/di.dart';
import 'package:tender/config/constants/supabase_tables_constants.dart';
import 'package:tender/config/constants/supabase_fields_constants.dart';
import 'package:tender/core/routes/routes.dart';

class LoginController extends GetxController {
  var isLoading = false;
  final idController = TextEditingController();
  final phoneController = TextEditingController();

  Future<bool> loginDoctor() async {
    try {
      isLoading = true;
      update();

      final response = await supabase
          .from(SupabaseTableConstants.doctors)
          .select()
          .eq(SupabaseFieldsConstants.doctorId, int.parse(idController.text))
          .eq(SupabaseFieldsConstants.phone, phoneController.text);

      isLoading = false;
      update();


      if (response.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      isLoading = false;
      update();

      Get.snackbar("Error", e.toString());
      return false;
    }
  }
  navigateToDashboard(){
    Get.toNamed(Routes.dashboard);
  }
}
