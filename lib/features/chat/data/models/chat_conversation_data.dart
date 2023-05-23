import 'package:flutter_chatgpt_clone/features/chat/domain/entities/chat_conversation_data_entity.dart';

class ChatConversationData extends ChatConversationDataEntity {
  ChatConversationDataContent? message;
  ChatConversationData({this.message});

  factory ChatConversationData.fromJson(Map<String, dynamic> json) {
    return ChatConversationData(
      message: ChatConversationDataContent.fromJson(json['message']),
    );
  }
}

class ChatConversationDataContent {
  String? content;
  String? role;
  ChatConversationDataContent({this.content, this.role});

  factory ChatConversationDataContent.fromJson(Map<String, dynamic> json) {
    return ChatConversationDataContent(
      content: json['content'],
      role: json['role'],
    );
  }
}
