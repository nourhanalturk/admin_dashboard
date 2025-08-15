import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tender/config/di/di.dart';
import 'package:tender/core/cache/app_cache.dart';
import 'package:tender/features/messages/domain/model/message_model.dart';

class MessagesController extends GetxController {
  TextEditingController messageController = TextEditingController();
  late String chatUid;
  List<MessageModel> messages = [];


  fetchMessages() async {
    chatUid = CacheData.chatUid;
    final currentUid = 2;

    final response = await supabase
        .from('messages')
        .select()
        .eq('chat_id', chatUid)
        .order('created_at', ascending: true);

    messages = response
        .map<MessageModel>((msg) => MessageModel.fromJson(msg, '$currentUid'))
        .toList();

    update();
  }

  sendMessage() async {

    String messageText = messageController.text;
    if (messageText.isEmpty) return;
    if (chatUid.isEmpty) {
      Get.snackbar('Error', 'Chat ID is not set.');
      return;
    }
    if (messageText.length > 500) {
      Get.snackbar('Error', 'Message is too long. Maximum 500 characters allowed.');
      return;
    }


    final senderId = 2;
    final senderType = 'doctor';
    final timestamp = DateTime.now().toIso8601String();

    await supabase.from('messages').insert({
      'chat_id': chatUid,
      'sender_id': senderId,
      'sender_type': senderType,
      'content': messageText,
      'created_at': timestamp,
    });


    await supabase.from('all_chats').update({
      'last_message': messageText,
      'updated_at': timestamp,
    }).eq('chat_id', chatUid);

    messageController.clear();
  }

  void listenToNewMessages() {
    final currentUid = 2;

    supabase.channel('messages_channel')
        .on(
      RealtimeListenTypes.postgresChanges,
      ChannelFilter(
        event: 'INSERT',
        schema: 'public',
        table: 'messages',
        filter: 'chat_id=eq.$chatUid',
      ),
          (payload, [ref]) {
        final newData = payload['new'];
        if (newData == null) return;

        final newMessage = MessageModel.fromJson(newData, '$currentUid');
        messages.add(newMessage);
        update();
      },
    )
        .subscribe();
  }


  @override
  void onInit() {
    chatUid = CacheData.chatUid;

    fetchMessages();
    listenToNewMessages();
    super.onInit();
  }
}
