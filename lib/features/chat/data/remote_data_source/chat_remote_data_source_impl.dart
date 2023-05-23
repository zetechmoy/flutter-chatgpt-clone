import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_chatgpt_clone/core/custom_exception.dart';
import 'package:flutter_chatgpt_clone/core/open_ai_data.dart';
import 'package:flutter_chatgpt_clone/features/chat/data/models/chat_converstaion_model.dart';
import 'package:flutter_chatgpt_clone/features/chat/data/remote_data_source/chat_remote_data_source.dart';
import 'package:flutter_chatgpt_clone/features/chat/domain/entities/chat_converstaion_entity.dart';
import 'package:flutter_chatgpt_clone/features/chat/domain/entities/chat_message_entity.dart';
import 'package:flutter_chatgpt_clone/features/global/const/app_const.dart';
import 'package:flutter_chatgpt_clone/features/global/http_client.dart';
import 'package:flutter_chatgpt_clone/features/global/provider/provider.dart';

class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {
  final CustomHttpClient httpClient;

  ChatRemoteDataSourceImpl({required this.httpClient});

  @override
  Future<ChatConversationEntity> chatConversation(
      String prompt,
      List<ChatMessageEntity> chatMessages,
      Function(bool isReqComplete) onCompleteReqProcessing) async {
    final String _endPoint = "chat/completions";

    onCompleteReqProcessing(true);

    final messages = chatMessages.map((chatMessage) {
      return chatMessage.toJson();
    }).toList();

    final rowBodyEncodedParams = json.encode({
      "model": kOpenAIModel,
      "temperature": 0.7,
      "max_tokens": 18000,
      "repeat_penalty": 1,
      "stop": ["Human:", "AI:"],
      "messages": messages
    });

    final response = await httpClient
        .post(
            Uri.parse(
              endPoint(
                _endPoint,
              ),
            ),
            body: rowBodyEncodedParams,
            headers: headerBearerOption(OPEN_AI_KEY))
        .timeout(const Duration(minutes: 10));

    if (response.statusCode == 200) {
      onCompleteReqProcessing(false);
      debugPrint(response.body);
      return ChatConversationModel.fromJson(json.decode(response.body));
    } else {
      onCompleteReqProcessing(false);
      throw ChatGPTServerException(
          message: json.decode(response.body)['error']['message']);
    }
  }
}
