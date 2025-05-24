import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiwee/src/features/home/presentation/pages/home_view.dart';
import 'package:tiwee/src/routes/routes.dart';

class ActiveCodePage extends StatelessWidget {
  ActiveCodePage({super.key});

  final TextEditingController codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0C1A), // dark background
      body: SafeArea(
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Left Side: Logo and List Users Button
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
                        image: AssetImage('assets/icons/Tiwee.png'), // <-- Add your logo to assets
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // List Users Button
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      padding:
                          const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    onPressed: () {
                      // Handle list users action
                    },
                    icon: const Icon(Icons.person),
                    label: const Text("LIST USERS"),
                  ),
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
                        prefixIcon: const Icon(Icons.security, color: Colors.white),
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
                        icon: const Icon(Icons.security, color: Colors.white),
                        label: const Text(
                          "ACTIVATION",
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          backgroundColor: Colors.white24,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {
                          final code = codeController.text.trim();
                          if (code.isNotEmpty) {
                            // Navigate to HomePage
                            Get.offAllNamed(TiweeRouts.homeRoute);
                          } else {
                            Get.snackbar("Error", "Please enter a valid activation code.",
                                backgroundColor: Colors.red, colorText: Colors.white);
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
