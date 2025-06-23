import 'package:get/get.dart';

import 'maincategories_logic.dart';

class MainCategoriesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MaincategoriesLogic());
  }
}
