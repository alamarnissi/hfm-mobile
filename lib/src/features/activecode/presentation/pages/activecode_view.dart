import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';

// import 'package:tiwee/src/features/home/presentation/pages/home_view.dart';
// import 'package:tiwee/src/features/activecode/presentation/widgets/loader_indicator.dart';
import 'package:tiwee/src/routes/routes.dart';
import 'package:tiwee/business_logic/provider/client_provider.dart';

class ActiveCodePage extends StatefulWidget {
  const ActiveCodePage({super.key});

  @override
  State<ActiveCodePage> createState() => _ActiveCodePageState();
}

class _ActiveCodePageState extends State<ActiveCodePage> {
  final TextEditingController codeController = TextEditingController();
  bool isLoading = false;

  Future<void> handleActivation() async {
    final code = codeController.text.trim();

    if (code.isEmpty) {
      Get.snackbar("Error", "Please enter a valid activation code.",
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    setState(() => isLoading = true);
    final result = await fetchClientM3U(code);
    setState(() => isLoading = false);
    //print result client data
    // print("result" + result.toString());
    if (result != null) {
      final storage = GetStorage();
      storage.write('device_model', result.client['model']);
      storage.write('serial_number', result.client['sn']);
      storage.write('mac_address', result.client['mac']);


      // Navigate to home
      Get.offAllNamed(TiweeRouts.maincategories, arguments: {
        'client': result.client,
        'groups': result.groups,
      });
    } else {
      Get.snackbar("Error", "Activation failed or code is invalid.",
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: const Color(0xFF0B0C1A), // dark background
      body: SafeArea(
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Left Side: Logo
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Logo Image
                  Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      image: const DecorationImage(
                        image: AssetImage(
                            'assets/icons/Tiwee.png'), // <-- Add your logo to assets
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),

              const SizedBox(width: 60), // space between columns

              // Right Side: Activation Form
              Container(
                width: 400,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Enter Your Activation Code",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Activation Code Field
                    TextField(
                      controller: codeController,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: "Activation Code",
                        hintStyle: const TextStyle(color: Colors.white54),
                        filled: true,
                        fillColor: Colors.black45,
                        prefixIcon:
                            const Icon(Icons.security, color: Colors.white),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Activation Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: isLoading ? null : handleActivation,
                        icon: isLoading
                            ? const SizedBox(
                                width: 18,
                                height: 18,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white),
                                ),
                              )
                            : const Icon(Icons.lock_open, color: Colors.white),
                        label: const Text(
                          "ACTIVATION",
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white24,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
