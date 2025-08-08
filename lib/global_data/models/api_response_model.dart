import 'package:tiwee/global_data/models/channel_model.dart';
import 'package:tiwee/global_data/models/client_model.dart';

class ApiResponse {
  final bool success;
  final String message;
  final ClientModel client;
  final Map<String, Map<String, List<Channel>>> data;

  ApiResponse({
    required this.success,
    required this.message,
    required this.client,
    required this.data,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      success: json['success'],
      message: json['message'],
      client: ClientModel.fromJson(json['client']),
      data: (json['data'] as Map<String, dynamic>).map((categoryKey, subcategories) {
        return MapEntry(
          categoryKey,
          (subcategories as Map<String, dynamic>).map((subKey, value) {
            return MapEntry(
              subKey,
              (value as List).map((e) => Channel.fromJson(e)).toList(),
            );
          }),
        );
      }),
    );
  }
}
