// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:flutter_dotenv/flutter_dotenv.dart';

// Future<String> sendToGroq(String message) async {

//   final apiKey = dotenv.env['GROQ_API_KEY'];

//   final response = await http.post(
//     Uri.parse("https://api.groq.com/openai/v1/chat/completions"),
//     headers: {
//       "Authorization": "Bearer $apiKey",
//       "Content-Type": "application/json"
//     },
//     body: jsonEncode({
//       "model": "llama-3.3-70b-versatile",
//       "messages": [
//         {
//           "role": "system",
//           "content":
//               "Your name is Kyra.You are a physiotherapy assistant for a hand rehabilitation app. Give clear instructions for exercises and recommended repetitions. Avoid medical diagnosis.make the responses short but warm and friendly"
//         },
//         {
//           "role": "user",
//           "content": message
//         }
//       ]
//     }),
//   );

//   final data = jsonDecode(response.body);

//   if (data["choices"] == null) {
//     return "Groq error: ${data["error"]?["message"]}";
//   }

//   return data["choices"][0]["message"]["content"];
// }

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<String> sendToGroq(String message) async {

  final apiKey = dotenv.env['GROQ_API_KEY'];

  if (apiKey == null || apiKey.isEmpty) {
    return "API key missing";
  }

  try {

    final response = await http.post(
      Uri.parse("https://api.groq.com/openai/v1/chat/completions"),
      headers: {
        "Authorization": "Bearer $apiKey",
        "Content-Type": "application/json"
      },
      body: jsonEncode({
        "model": "llama-3.3-70b-versatile",
        "messages": [
          {
            "role": "system",
            "content":
                "Your name is Kyra. You are a physiotherapy assistant for a hand rehabilitation app. Give clear exercise instructions and recommended repetitions. Avoid medical diagnosis. Keep responses short, warm, and friendly."
          },
          {
            "role": "user",
            "content": message
          }
        ]
      }),
    );

    if (response.statusCode != 200) {
      return "Server error (${response.statusCode})";
    }

    final data = jsonDecode(response.body);

    final choices = data["choices"];

    if (choices == null || choices.isEmpty) {
      return "No response from AI";
    }

    return choices[0]["message"]["content"] ?? "Empty response";

  } catch (e) {
    return "Connection error. Please try again.";
  }
}