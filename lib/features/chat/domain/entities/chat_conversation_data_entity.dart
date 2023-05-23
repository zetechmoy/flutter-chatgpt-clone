import 'package:equatable/equatable.dart';
import 'package:flutter_chatgpt_clone/features/chat/data/models/chat_conversation_data.dart';

class ChatConversationDataEntity extends Equatable {
  final ChatConversationDataContent? message;

  ChatConversationDataEntity({this.message});

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}
