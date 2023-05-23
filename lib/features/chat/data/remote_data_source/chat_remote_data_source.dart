import 'package:flutter_chatgpt_clone/features/chat/domain/entities/chat_converstaion_entity.dart';
import 'package:flutter_chatgpt_clone/features/chat/domain/entities/chat_message_entity.dart';

abstract class ChatRemoteDataSource {
  Future<ChatConversationEntity> chatConversation(
    String prompt,
    List<ChatMessageEntity> chatMessages,
    Function(bool isReqComplete) onCompleteReqProcessing,
  );
}
