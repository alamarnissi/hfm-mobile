import 'package:get/get.dart';

import 'activecode_logic.dart';

class ActiveCodeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ActiveCodeLogic());
  }
}
