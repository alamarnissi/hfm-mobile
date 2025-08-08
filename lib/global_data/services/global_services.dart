import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  static const String _url = 'https://your.api.url/endpoint';
  static const String _storageKey = 'daily_api_response';

  Future<void> fetchAndStoreApiResponse() async {
    try {
      final response = await http.get(Uri.parse(_url));

      if (response.statusCode == 200) {
        final jsonString = response.body;
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString(_storageKey, jsonString);
        print("✅ API response stored successfully.");
      } else {
        print("❌ Failed to fetch API: ${response.statusCode}");
      }
    } catch (e) {
      print("❌ Exception while fetching API: $e");
    }
  }


  Future<String?> getStoredResponse() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_storageKey);
  }
}
