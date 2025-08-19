import 'package:flutter_dotenv/flutter_dotenv.dart'; // Import dotenv

class EnvConfig {
  static String get openAIApiKey { // Change to getter, not const
    return dotenv.env['OPENAI_API_KEY'] ?? '';
  }
  
  static const String openAIApiUrl = 'https://api.openai.com/v1/chat/completions';
}