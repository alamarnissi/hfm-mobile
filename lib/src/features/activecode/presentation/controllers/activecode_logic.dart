
import 'package:get/get.dart';

import 'activecode_state.dart';

class ActiveCodeLogic extends GetxController with StateMixin<ActiveCodeState>{

  @override
  void onInit() {
    change(null,status: RxStatus.success());
    
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
