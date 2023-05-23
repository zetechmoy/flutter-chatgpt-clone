import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chatgpt_clone/core/custom_exception.dart';
import 'package:flutter_chatgpt_clone/core/open_ai_data.dart';
import 'package:flutter_chatgpt_clone/features/chat/domain/entities/chat_message_entity.dart';
import 'package:flutter_chatgpt_clone/features/chat/domain/usecases/chat_converstaion_usecase.dart';
import 'package:flutter_chatgpt_clone/features/global/const/app_const.dart';

part 'chat_conversation_state.dart';

class ChatConversationCubit extends Cubit<ChatConversationState> {
  final ChatConversationUseCase chatConversationUseCase;

  ChatConversationCubit({required this.chatConversationUseCase})
      : super(ChatConversationInitial());

  List<ChatMessageEntity> _chatMessages = [];

  Future<void> chatConversation({
    required ChatMessageEntity chatMessage,
    required Function(bool isReqComplete) onCompleteReqProcessing,
  }) async {
    try {
      if (_chatMessages.isEmpty) {
        _chatMessages.add(ChatMessageEntity(
            messageId: ChatGptConst.System,
            queryPrompt: kInitModelSystemMessage));
      }

      _chatMessages.add(chatMessage);

      emit(
        ChatConversationLoaded(
          chatMessages: _chatMessages,
        ),
      );

      final conversationData = await chatConversationUseCase.call(
          chatMessage.queryPrompt!, _chatMessages, onCompleteReqProcessing);

      final chatMessageResponse = ChatMessageEntity(
          messageId: ChatGptConst.AIBot,
          promptResponse: conversationData.choices != null &&
                  conversationData.choices!.isNotEmpty &&
                  conversationData.choices!.first.message != null &&
                  conversationData.choices!.first.message!.content != null
              ? conversationData.choices!.first.message!.content
              : "");

      _chatMessages.add(chatMessageResponse);

      emit(ChatConversationLoaded(
        chatMessages: _chatMessages,
      ));
    } on SocketException catch (e) {
      final chatMessageResponse = ChatMessageEntity(
          messageId: ChatGptConst.AIBot, promptResponse: e.message);

      _chatMessages.add(chatMessageResponse);

      emit(ChatConversationLoaded(
        chatMessages: _chatMessages,
      ));
    } on ChatGPTServerException catch (e) {
      final chatMessageResponse = ChatMessageEntity(
          messageId: ChatGptConst.AIBot, promptResponse: e.message);

      _chatMessages.add(chatMessageResponse);

      emit(ChatConversationLoaded(
        chatMessages: _chatMessages,
      ));
    }
  }
}
