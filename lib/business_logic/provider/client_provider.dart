import 'package:dio/dio.dart';
import '../model/client_m3u_data.dart'; // the model above
import 'package:get_storage/get_storage.dart';

Future<ClientM3UData?> fetchClientM3U(String code) async {
  try {
    Dio dio = Dio(BaseOptions(
      connectTimeout: const Duration(seconds: 256),
      receiveTimeout: const Duration(seconds: 256),
    ));
    final response = await dio.post(
      'http://10.0.2.2:8000/api/verify-activecode', // or your LAN IP
      data: {'code': code},
      options: Options(
        headers: {'Content-Type': 'application/json'},
        responseType: ResponseType.json,
      ),
    );

    print("✅ data: ${response.data}");

    if (response.statusCode == 200 && response.data['success'] == true) {
      if (response.headers.map['content-type']?.first.contains('application/json') == true) {

        // Safe to use response.data directly
        final data = response.data;

        if (data['client'] == null || data['data'] == null) {
          print("⚠️ Response is missing 'client' or 'data' keys.");
          return null;
        }
        
        final storage = GetStorage();
        final client = storage.read('client_data');
        final channels = storage.read('channel_groups');

        if(client == null && channels == null) {
          // Cache data
          storage.write('client_data', data['client']);
          storage.write('channel_groups', data['data']);
        }

        return ClientM3UData.fromJson({
          'client': data['client'],
          'groups': data['data'],
        });
      }
    } else {
      print('❌ Server responded with error: ${response.data['message']}');
    }
  } catch (e) {
    print('❌ Error during fetchClientM3U: $e');
  }
  return null;
}
