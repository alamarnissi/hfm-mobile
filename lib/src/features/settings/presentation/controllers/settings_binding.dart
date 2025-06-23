import 'package:get/get.dart';

import 'settings_logic.dart';

class SettingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SettingsLogic());
  }
}
