import 'package:flutter_chatgpt_clone/core/open_ai_data.dart';
import 'package:flutter_chatgpt_clone/features/global/provider/provider.dart';
import 'package:http/http.dart' as http;

class CustomHttpClient extends http.BaseClient {
  http.Client _httpClient = new http.Client();

  CustomHttpClient();

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    request.headers.addAll(headerBearerOption(OPEN_AI_KEY));
    return _httpClient.send(request);
  }
}
