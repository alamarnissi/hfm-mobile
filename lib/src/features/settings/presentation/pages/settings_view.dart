import 'package:tiwee/core/consts.dart';
import 'package:tiwee/src/features/settings/presentation/controllers/settings_logic.dart';
import 'package:tiwee/src/features/home/presentation/widgets/footer.dart';
import 'package:tiwee/src/features/home/presentation/widgets/header.dart';
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

    return SafeArea(
        child: Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 35, 43, 130),
              Color.fromARGB(255, 8, 44, 98)
            ],
          ),
        ),
        child: Column(
          children: [
            const HeaderApp(),

            // 🧠 Dynamic Group List from Cached Channels
            Expanded(
              child: Column(
                children: [
                  const Text(
                    "Settings",
                    style: TextStyle(fontSize: 24, color: Color.fromARGB(179, 125, 248, 53)),
                  ),
                  const SizedBox(height: 24),
                  _buildInfoTile("Device Model", deviceModel),
                  _buildInfoTile("Serial Number", serialNumber),
                  _buildInfoTile("MAC Address", macAddress),
                ],
              ),
            ),

            // Pass client data to footer
            FooterApp(),
          ],
        ),
      ),
    ));
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
