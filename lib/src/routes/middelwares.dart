import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  GetPage? onPageCalled(GetPage? page) {
    if (kDebugMode) {
      print(page?.name);
    }
    return super.onPageCalled(page);
  }


}