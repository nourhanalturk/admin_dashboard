import 'package:tender/features/chats/domain/model/patient_data_model.dart';
import 'chat_model.dart';

class ChatWithPatient {
  ChatModel chat;
  PatientDataModel patient;

  ChatWithPatient({
    required this.chat,
    required this.patient,
  });
}
