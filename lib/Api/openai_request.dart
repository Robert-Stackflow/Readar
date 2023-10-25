import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../Models/message_data.dart';
import '../Utils/hive_util.dart';

class OpenAIRequest {
  static Future<dynamic> sendMessage(
      String message, List<MessageData> history) async {
    String? apiKey = HiveUtil.getString(key: HiveUtil.apiKeyKey);
    String? baseUrl = HiveUtil.getString(key: HiveUtil.apiUrlKey);
    Map<String, String> headers = {
      "Content-Type": "application/json; charset=UTF-8",
      "Authorization": "Bearer $apiKey"
    };
    List<dynamic> messages = [];
    messages.addAll(history.reversed
        .take(8)
        .toList()
        .reversed
        .map((e) => {
              "role": e.sender == 0 ? "user" : "assistant",
              "content": e.content
            })
        .toList());
    messages.add({"role": "user", "content": message});
    var res = await http.post(
      Uri.parse(baseUrl ?? ""),
      headers: headers,
      body: json.encode(
        {"model": "gpt-3.5-turbo", "messages": messages},
      ),
    );
    if (res.statusCode == 200) {
      final resultBody = utf8.decode(res.bodyBytes);
      final String result =
          jsonDecode(resultBody)["choices"][0]["message"]["content"];
      return result.trim();
    } else {
      return "开小差中......";
    }
  }

  static Future<dynamic> sendMessageProxy(
      String message, List<MessageData> history) async {
    String? baseUrl = HiveUtil.getString(key: HiveUtil.apiCustomUrlKey);
    String? apiCode = HiveUtil.getString(key: HiveUtil.apiCodeKey);
    Map<String, String> headers = {
      "Content-Type": "application/json; charset=UTF-8",
      "access-code": '$apiCode',
      "path": "v1/chat/completions"
    };
    List<dynamic> messages = [];
    messages.addAll(history.reversed
        .take(8)
        .toList()
        .reversed
        .map((e) => {
              "role": e.sender == 0 ? "user" : "assistant",
              "content": e.content
            })
        .toList());
    messages.add({"role": "user", "content": message});
    var res = await http
        .post(
      Uri.parse(baseUrl ?? ""),
      headers: headers,
      body: json.encode(
        {"model": "gpt-3.5-turbo", "messages": messages, "stream": false},
      ),
    )
        .timeout(const Duration(seconds: 20), onTimeout: () {
      return http.Response("", 500);
    }).catchError((_) {
      return http.Response("", 500);
    });
    if (res.statusCode == 200) {
      String resultBody = utf8.decode(res.bodyBytes);
      resultBody = resultBody.replaceAll("```json", "");
      resultBody = resultBody.replaceAll("```", "");
      final String result =
          jsonDecode(resultBody)["choices"][0]["message"]["content"];
      return result.trim();
    } else {
      return "开小差中......";
    }
  }

  static Future<dynamic> moderationProxy(String message) async {
    String? baseUrl = HiveUtil.getString(key: HiveUtil.apiCustomUrlKey);
    String? apiCode = HiveUtil.getString(key: HiveUtil.apiCodeKey);
    Map<String, String> headers = {
      "Content-Type": "application/json; charset=UTF-8",
      "access-code": '$apiCode',
      "path": "v1/moderations"
    };
    var res = await http
        .post(
      Uri.parse(baseUrl ?? ""),
      headers: headers,
      body: json.encode(
        {"input": message},
      ),
    )
        .timeout(const Duration(seconds: 20), onTimeout: () {
      return http.Response("", 500);
    }).catchError((_) {
      return http.Response("", 500);
    });
    if (res.statusCode == 200) {
      final bool result = jsonDecode(res.body)["results"][0]["flagged"];
      final bool sexual = jsonDecode(res.body)["results"][0]["categories"]
              ["sexual"] ||
          jsonDecode(res.body)["results"][0]["categories"]["sexual/minors"];
      final bool hate = jsonDecode(res.body)["results"][0]["categories"]
              ["hate"] ||
          jsonDecode(res.body)["results"][0]["categories"]["hate/threatening"];
      final bool violence = jsonDecode(res.body)["results"][0]["categories"]
              ["violence"] ||
          jsonDecode(res.body)["results"][0]["categories"]["violence/graphic"];
      final bool selfHarm =
          jsonDecode(res.body)["results"][0]["categories"]["self-harm"];
      if (!result) {
        return Moderation.none;
      } else {
        if (sexual) {
          return Moderation.sexual;
        }
        if (violence) {
          return Moderation.violence;
        }
        if (selfHarm) {
          return Moderation.selfharm;
        }
        if (hate) {
          return Moderation.hate;
        }
      }
    } else {
      return Moderation.none;
    }
  }
}

enum Moderation { none, sexual, hate, violence, selfharm }
