import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tender/config/constants/supabase_tables_constants.dart';
import 'package:tender/config/di/di.dart';
import 'package:tender/core/resources/manager_strings.dart';
import 'package:tender/features/available_times/domain/model/available_times_model.dart';

class AvailableTimesController extends GetxController {
  List<AvailableTimesModel> availableTimesList = [];
  TextEditingController timeController = TextEditingController();
  bool showAddTimeField = false;
  DateTime? selectedDate;
  List<String> newTimes = [];

  void toggleAddTimeField() {
    showAddTimeField = !showAddTimeField;
    update();
  }

  void addNewTime(String time) {
    if (!newTimes.contains(time)) {
      newTimes.add(time);
      update();
    }
  }

  void removeNewTime(String time) {
    newTimes.remove(time);
    update();
  }

  Future<void> saveNewDate() async {
    if (selectedDate == null || newTimes.isEmpty) {
      Get.snackbar(ManagerStrings.errorOccurred,
          ManagerStrings.selectDateAndTime);
      return;
    }

    final values = {
      'doctor_id': 2,
      'available_date': selectedDate!.toIso8601String(),
      'available_time': newTimes,
    };

    try {
      await supabase.from(SupabaseTableConstants.availableTimes).insert(values);

      availableTimesList.add(
        AvailableTimesModel(
          availableDate: selectedDate!,
          availableTimes: List.from(newTimes),
        ),
      );

      selectedDate = null;
      newTimes.clear();

      update();

      Get.snackbar(ManagerStrings.timeAddedSuccessfully, '');
    } catch (error) {
      Get.snackbar(ManagerStrings.errorOccurred, error.toString());
    }
  }


  void addTime(AvailableTimesModel item, String newTime) async {
    item.availableTimes.add(newTime);
    update();
    await supabase
        .from(SupabaseTableConstants.availableTimes)
        .update({'available_time': item.availableTimes})
        .eq('doctor_id', 2)
        .eq('available_date', item.availableDate.toIso8601String())
        .then(
          (value) {
        timeController.clear();
        Get.snackbar(ManagerStrings.timeAddedSuccessfully, '');
      },
    )
        .catchError((error) {
      Get.snackbar(ManagerStrings.errorOccurred, error.toString());
    });
  }

  void removeTime(AvailableTimesModel item, String time) async {
    item.availableTimes.remove(time);
    update();
    await supabase
        .from(SupabaseTableConstants.availableTimes)
        .update({'available_time': item.availableTimes})
        .eq('doctor_id', 2)
        .eq('available_date', item.availableDate.toIso8601String())
        .then(
          (value) {
        Get.snackbar(ManagerStrings.timeRemovedSuccessfully, '');
      },
    )
        .catchError((error) {
      Get.snackbar(ManagerStrings.errorOccurred, error.toString());
    });
  }


  getDoctorAvailableTimes() async {
    final response = await supabase
        .from(SupabaseTableConstants.availableTimes)
        .select()
        .eq('doctor_id', 2);
    availableTimesList = List<AvailableTimesModel>.from(
        response.map((e) => AvailableTimesModel.fromJson(e)));
    update();
  }

  deleteDate(AvailableTimesModel item) async {
    await supabase
        .from(SupabaseTableConstants.availableTimes)
        .delete()
        .eq('doctor_id', 2)
        .eq('available_date', item.availableDate.toIso8601String())
        .then(
          (value) {
        availableTimesList.remove(item);
        update();
        Get.snackbar(ManagerStrings.timeRemovedSuccessfully, '');
      },
    ).catchError((error) {
      Get.snackbar(ManagerStrings.errorOccurred, error.toString());
    });
  }

  addNewDate() {

  }

  @override
  void onInit() {
    getDoctorAvailableTimes();
    super.onInit();
  }
}
