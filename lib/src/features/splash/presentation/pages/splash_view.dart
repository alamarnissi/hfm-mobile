import 'package:Tiwee/core/consts.dart';
import 'package:Tiwee/src/features/splash/presentation/controllers/splash_logic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';


class SplashPage extends GetView<SplashLogic> {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: controller.obx((state) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(kSplashLoading,
                width: Get.width / 4),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "hmm its time to TV show 😜",
              style: TextStyle(fontSize: 20, color: Colors.white70),
            )
          ],
        ),
      ),)
    );
  }
}
