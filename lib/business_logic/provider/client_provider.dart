import 'package:device_info_plus/device_info_plus.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:get_storage/get_storage.dart';
import 'package:dio/dio.dart';
import '../model/client_m3u_data.dart';

Future<ClientM3UData?> fetchClientM3U(String code) async {
  try {
    final storage = GetStorage();

    // Check if device info already stored
    String? deviceModel = storage.read('device_model');
    String? serialNumber = storage.read('serial_number');
    String? macAddress = storage.read('mac_address');

    // If not stored, fetch them now
    if (deviceModel == null || serialNumber == null || macAddress == null) {
      final deviceInfoPlugin = DeviceInfoPlugin();
      final info = NetworkInfo();

      final androidInfo = await deviceInfoPlugin.androidInfo;
      deviceModel = androidInfo.model;
      serialNumber = androidInfo.serialNumber ?? androidInfo.id ?? 'unknown';

      macAddress = await info.getWifiBSSID() ?? await info.getWifiIP() ?? 'unknown';
    }

    Dio dio = Dio(BaseOptions(
      connectTimeout: const Duration(seconds: 256),
      receiveTimeout: const Duration(seconds: 256),
    ));

    final response = await dio.post(
      'http://10.0.2.2:8000/api/verify-activecode',
      data: {
        'code': code,
        'device_model': deviceModel,
        'serial_number': serialNumber,
        'mac_address': macAddress,
      },
      options: Options(
        headers: {'Content-Type': 'application/json'},
        responseType: ResponseType.json,
      ),
    );

    if (response.statusCode == 200 && response.data['success'] == true) {
      final data = response.data;

      if (data['client'] == null || data['data'] == null) {
        print("⚠️ Response is missing 'client' or 'data' keys.");
        return null;
      }

      return ClientM3UData.fromJson({
        'client': data['client'],
        'groups': data['data'],
      });
    } else {
      print('❌ Server responded with error: ${response.data['message']}');
    }
  } catch (e) {
    print('❌ Error during fetchClientM3U: $e');
  }
  return null;
}
