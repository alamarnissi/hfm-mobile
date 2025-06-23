import 'package:get_storage/get_storage.dart';
import 'package:tiwee/business_logic/model/client_m3u_data.dart';
import 'package:tiwee/src/routes/routes.dart';
import 'package:get/get.dart';

import 'splash_state.dart';

class SplashLogic extends GetxController with StateMixin<SplashState>{

  @override
  void onInit() {
    change(null,status: RxStatus.success());
      Future.delayed(Duration(seconds: 2),() {
        Get.offAllNamed(TiweeRouts.activecodeRoute);
      },);
    // final storage = GetStorage();
    // final client = storage.read('client_data');
    // final channels = storage.read('channel_groups');

    // if (client != null && channels != null) {
    //   // Optional: wrap in ClientM3UData class
    //   final cached = ClientM3UData(client: Map<String, dynamic>.from(client), groups: Map<String, List<dynamic>>.from(channels));

    //   // Go to maincategories directly
    //   Get.offAllNamed(TiweeRouts.maincategories, arguments: cached);
    // }else {
    //   change(null,status: RxStatus.success());
    //   Future.delayed(Duration(seconds: 2),() {
    //     Get.offAllNamed(TiweeRouts.activecodeRoute);
    //   },);
    // }
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
