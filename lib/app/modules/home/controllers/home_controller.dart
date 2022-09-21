import 'package:get/get.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController
  RxBool condition = false.obs;
  RxList number = ["1", "2", "3", "4", "5", "6"].obs;
  RxList dragNumber = [].obs;
  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
