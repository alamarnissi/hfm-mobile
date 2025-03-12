import 'package:tiwee/src/routes/routes.dart';
import 'package:get/get.dart';

import 'splash_state.dart';

class SplashLogic extends GetxController with StateMixin<SplashState>{

  @override
  void onInit() {
    change(null,status: RxStatus.success());
    Future.delayed(Duration(seconds: 2),() {
      Get.offAllNamed(TiweeRouts.homeRoute);
    },);
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}
