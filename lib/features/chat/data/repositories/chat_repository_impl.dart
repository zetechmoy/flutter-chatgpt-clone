import 'package:flutter_chatgpt_clone/features/chat/data/remote_data_source/chat_remote_data_source.dart';
import 'package:flutter_chatgpt_clone/features/chat/domain/entities/chat_converstaion_entity.dart';
import 'package:flutter_chatgpt_clone/features/chat/domain/entities/chat_message_entity.dart';
import 'package:flutter_chatgpt_clone/features/chat/domain/repositories/chat_repository.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatRemoteDataSource remoteDataSource;

  ChatRepositoryImpl({required this.remoteDataSource});

  @override
  Future<ChatConversationEntity> chatConversation(
          String prompt,
          List<ChatMessageEntity> chatMessages,
          Function(bool isReqComplete) onCompleteReqProcessing) async =>
      remoteDataSource.chatConversation(
          prompt, chatMessages, onCompleteReqProcessing);
}
