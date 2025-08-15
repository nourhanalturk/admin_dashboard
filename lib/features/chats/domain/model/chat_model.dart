import 'package:tender/config/constants/supabase_fields_constants.dart';

class ChatModel {
  String? chatId;

  int? doctorId;

  String? patientId;

  String? lastMessage;

  String? updatedAt;

  ChatModel({
    required this.chatId,
    required this.doctorId,
    required this.patientId,
    required this.lastMessage,
    required this.updatedAt,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      chatId: json[SupabaseFieldsConstants.chatId],
      doctorId: json[SupabaseFieldsConstants.doctorId],
      patientId: json[SupabaseFieldsConstants.patientId],
      lastMessage: json[SupabaseFieldsConstants.lastMessage],
      updatedAt: json[SupabaseFieldsConstants.updatedAt],
    );
  }
}
