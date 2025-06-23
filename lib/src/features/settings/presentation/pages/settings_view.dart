import 'package:tiwee/core/consts.dart';
import 'package:tiwee/src/features/settings/presentation/controllers/settings_logic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SettingsPage extends GetView<SettingsLogic> {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final storage = GetStorage();

    final deviceModel = storage.read('device_model') ?? 'Unknown';
    final serialNumber = storage.read('serial_number') ?? 'Unknown';
    final macAddress = storage.read('mac_address') ?? 'Unknown';

    return Scaffold(
      backgroundColor: const Color(0xFF0B0C1A),
      body: controller.obx(
        (state) => Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Settings",
                  style: TextStyle(fontSize: 24, color: Colors.white70),
                ),
                const SizedBox(height: 24),
                _buildInfoTile("Device Model", deviceModel),
                _buildInfoTile("Serial Number", serialNumber),
                _buildInfoTile("MAC Address", macAddress),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoTile(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Text(
        "$title: $value",
        style: const TextStyle(
          fontSize: 16,
          color: Colors.white70,
        ),
      ),
    );
  }
}
