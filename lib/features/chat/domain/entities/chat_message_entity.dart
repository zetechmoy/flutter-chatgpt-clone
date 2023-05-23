import 'package:equatable/equatable.dart';
import 'package:flutter_chatgpt_clone/features/global/const/app_const.dart';

class ChatMessageEntity extends Equatable {
  final String? messageId;
  final String? queryPrompt;
  final String? promptResponse;

  ChatMessageEntity({this.messageId, this.queryPrompt, this.promptResponse});

  @override
  List<Object?> get props => [messageId, queryPrompt, promptResponse];

  toJson() => {"role": messageId, "content": queryPrompt};
}
