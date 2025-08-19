import 'package:http/http.dart' as http;
import 'dart:convert';
import '../config/env_config.dart';
import '../../config/constants.dart';

class ChatService {
  Future<String> sendMessage(String message) async {
    if (EnvConfig.openAIApiKey.isEmpty) {
      // We print the value of the string EnvConfig.openAIApiKey
      throw Exception('API key not configured');
    }

    try {
      final response = await http.post(
        Uri.parse(EnvConfig.openAIApiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${EnvConfig.openAIApiKey}',
        },
        body: jsonEncode({
          'model': 'gpt-3.5-turbo',
          'messages': [
            {'role': 'system', 'content': AppStrings.systemMessage},
            {'role': 'user', 'content': message}
          ],
          'temperature': 0.7,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['choices'][0]['message']['content'];
      } else {
        throw Exception('API Error: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Connection error: $e');
    }
  }
}