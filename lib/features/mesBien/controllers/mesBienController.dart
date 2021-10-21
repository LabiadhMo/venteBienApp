import 'package:get/get.dart';

class MesBienController extends GetxController {
  int selectedBien = -1;
  updateSelected(int index) {
    if (index == selectedBien)
      selectedBien = -1;
    else
      selectedBien = index;
    update();
  }
}
