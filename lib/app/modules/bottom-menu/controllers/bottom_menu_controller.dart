import 'package:get/get.dart';

class BottomMenuController extends GetxController {
  //TODO: Implement BottomMenuController

  var currentIndex = 0.obs;

  void changePage(int index) {
    currentIndex.value = index;
  }
}
