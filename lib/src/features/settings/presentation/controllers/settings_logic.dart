
import 'package:get/get.dart';
import 'settings_state.dart';

class SettingsLogic extends GetxController with StateMixin<SettingsState> {
  @override
  void onInit() {

    change(null, status: RxStatus.success());
    super.onInit();
  }

}
