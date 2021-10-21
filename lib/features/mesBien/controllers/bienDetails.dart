import 'package:get/get.dart';
import 'package:oikos/features/auth/controllers/authController.dart';
import 'package:oikos/features/mesBien/data/models/ajoutBienFomModel.dart';
import 'package:oikos/features/mesBien/data/providers/bienDetailsEndPoint.dart';
import 'package:oikos/features/mesBien/data/providers/mesBienEndPoints.dart';

class BienDetailsController extends GetxController {
  AjoutBienFormModel bienModel;
  BienDetailsEndPoint bienDetailsEndPoint = BienDetailsEndPoint();
  AuthController authController = Get.find();
  bool init = false;
  List features;
  initBien(String id) async {
    bienModel =
        AjoutBienFormModel.fromJson(await bienDetailsEndPoint.getProperty(
      id,
      authController.token,
    ));
    features = [bienModel.surface.toString() + ' m²'];

    if (bienModel.sallon == true) features.add('Sallon');
    if (bienModel.cuisine == true) features.add('Cuisine');
    if (bienModel.terasse == true) features.add('Terrasse');
    if (bienModel.garage == true) features.add('Garage');
    if (bienModel.balcon == true) features.add('Balcon');
    if (bienModel.jardin == true) features.add('Jardin');
    if (bienModel.cave == true) features.add('Cave');
    if (bienModel.piscine == true) features.add('Piscine');
    features.add('Depuis ' + bienModel.constructionDate.toString());
    features.add('vue ' + bienModel.vue);
    features.add(bienModel.standing + ' standing');
    features.add('Emplacement ' + bienModel.emplacement);
    String export = "";
    if (bienModel.exportationNord == true) export = export + "Nord ";
    if (bienModel.exportationOuest == true) export = export + "Ouest ";
    if (bienModel.exportationEst == true) export = export + "Est ";
    if (bienModel.exportationSud == true) export = export + "Sud";
    features.add(export);
    init = true;

    update();
  }

  Future delete(String id, String token) {
    MesBienEndPoint mesBienEndPoint = MesBienEndPoint();
    return mesBienEndPoint.bienDelete(id, token);
  }
}
