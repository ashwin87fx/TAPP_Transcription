import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class SummarizeController extends GetxController {
  final TextEditingController textController = TextEditingController();
  var resultSummary = "".obs;
  var isLoading = false.obs;

  Future<void> summarizeText() async {
    final text = textController.text.trim();
    if (text.isEmpty) {
      Get.snackbar("Error", "Please enter some text to summarize.");
      return;
    }

    isLoading.value = true;
    resultSummary.value = "";

    try {
      final url = Uri.parse("http://127.0.0.1:8000/summarize_text");
      
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"text": text}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        resultSummary.value = data['summary'] ?? "No summary returned.";
      } else {
        resultSummary.value = "Error: ${response.statusCode} - ${response.body}";
      }
    } catch (e) {
      resultSummary.value = "Connection Error: $e";
    } finally {
      isLoading.value = false;
    }
  }

  void clear() {
    textController.clear();
    resultSummary.value = "";
  }
}
