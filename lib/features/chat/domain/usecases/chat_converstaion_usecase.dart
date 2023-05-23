import 'package:flutter_chatgpt_clone/features/chat/domain/entities/chat_converstaion_entity.dart';
import 'package:flutter_chatgpt_clone/features/chat/domain/entities/chat_message_entity.dart';
import 'package:flutter_chatgpt_clone/features/chat/domain/repositories/chat_repository.dart';

class ChatConversationUseCase {
  final ChatRepository repository;

  ChatConversationUseCase({required this.repository});

  Future<ChatConversationEntity> call(
      String prompt,
      List<ChatMessageEntity> chatMessages,
      Function(bool isReqComplete) onCompleteReqProcessing) {
    return repository.chatConversation(
        prompt, chatMessages, onCompleteReqProcessing);
  }
}
