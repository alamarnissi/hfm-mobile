

import 'package:flutter/material.dart';
import 'package:tiwee/src/routes/routes.dart';
import 'package:get/get.dart';

class HeaderApp extends StatelessWidget {
  const HeaderApp({super.key});

  @override
  Widget build(BuildContext context) {

    return Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 16.0, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "HFM STREAM",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Row(children: [
                    Get.currentRoute != TiweeRouts.homeRoute ?
                    IconButton(
                      icon: Icon(Icons.home_outlined, color: Colors.white),
                      onPressed: () {
                        // Handle logout
                        Get.offAllNamed(TiweeRouts.homeRoute);
                      },
                    ) :
                    IconButton(
                      icon: Icon(Icons.category, color: Colors.white),
                      onPressed: () {
                        // Handle logout
                        Get.offAllNamed(TiweeRouts.maincategories);
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.settings, color: Colors.white),
                      onPressed: () {
                        // Handle logout
                        Get.offAllNamed(TiweeRouts.settings);
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.logout, color: Colors.white),
                      onPressed: () {
                        // Handle logout
                        Get.offAllNamed(TiweeRouts.activecodeRoute);
                      },
                    ),
                  ])
                ],
              ),
            );
  }
}

