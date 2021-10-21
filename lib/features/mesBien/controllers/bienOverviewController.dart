import 'package:get/get.dart';
import 'package:oikos/features/mesBien/data/models/ajoutBienFomModel.dart';

class BienOverviewController extends GetxController {
  RxBool isScreenOne = true.obs;
  RxInt selectedPrice = 2.obs;
  AjoutBienFormModel ajoutBienFormModel;

  setBienModel(Map ma) {
    ajoutBienFormModel = AjoutBienFormModel.fromJson(ma);
  }

  toggleIsScreenOne() {
    isScreenOne.value = !isScreenOne.value;
    update();
  }

  updateSelectedPrice(int v) {
    selectedPrice.value = v;
    update();
  }
}
