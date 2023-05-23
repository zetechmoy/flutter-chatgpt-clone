import 'package:flutter_chatgpt_clone/features/chat/chat_injection_container.dart';
import 'package:flutter_chatgpt_clone/features/global/http_client.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> init() async {
  final CustomHttpClient httpClient = CustomHttpClient();

  sl.registerLazySingleton<CustomHttpClient>(() => httpClient);

  await chatInjectionContainer();
}
