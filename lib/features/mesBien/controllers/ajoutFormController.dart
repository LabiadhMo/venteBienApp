import 'dart:io';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:oikos/features/auth/controllers/authController.dart';
import 'package:oikos/features/mesBien/data/models/ajoutBienFomModel.dart';
import 'package:oikos/features/mesBien/data/providers/bienDetailsEndPoint.dart';
import 'package:oikos/features/mesBien/data/providers/estimationEndPoint.dart';

class AjoutFormController extends GetxController {
  Rx<AjoutBienFormModel> ajoutBienFormModel = AjoutBienFormModel().obs;
  RxDouble progress = 0.0.obs;
  AjoutBienFormModel finalForm;
  AjoutFormController();
  List<String> feat;
  RxInt selectedPic;
  bool widgetLoaded = true;
  bool isAddNew = true;
  bool editInitialized = false;
  Position _currentPosition;
  String currentAddress = 'En cours ...';
  bool addressInitialized = false;
  toggleEditInit() {
    editInitialized = !editInitialized;
    update();
  }

  printloc() {
    _getCurrentLocation();
  }

  _getCurrentLocation() {
    Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best,
            forceAndroidLocationManager: true)
        .then((Position position) {
      _currentPosition = position;
      _getAddressFromLatLng();
    }).catchError((e) {
      print(e);
    });
  }

  _getAddressFromLatLng() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude,
          localeIdentifier: 'en');
      Placemark place = placemarks[0];
      print('street' + place.street);
      print('sub' + place.subLocality);
      print('pstc' + place.postalCode);
      ajoutBienFormModel.value.street = place.street;
      ajoutBienFormModel.value.city = place.locality;
      ajoutBienFormModel.value.country = place.country;
      currentAddress = "${place.street}, ${place.locality}, ${place.country}";
      print(currentAddress);

      addressInitialized = true;
      update();
    } catch (e) {
      print(e);
    }
  }

  Future<int> insertBien() async {
    EstimationEndPoint estimationEndPoint = EstimationEndPoint();
    AuthController authController = Get.find();
    if (isAddNew)
      finalForm = AjoutBienFormModel.fromJson(await estimationEndPoint
          .getProperty(authController.token, ajoutBienFormModel.toJson()));
    else
      finalForm = AjoutBienFormModel.fromJson(
          (await estimationEndPoint.updateBien(ajoutBienFormModel.value.id,
                  authController.token, ajoutBienFormModel.toJson()))
              .body);
    ajoutBienFormModel.value.id = finalForm.id;
    ajoutBienFormModel.value.status = finalForm.status;
    ajoutBienFormModel.value.createdAt = finalForm.createdAt;
    ajoutBienFormModel.value.updatedAt = finalForm.updatedAt;
    ajoutBienFormModel.value.propLikes = finalForm.propLikes;
    ajoutBienFormModel.value.fileBiens = finalForm.fileBiens;
    setFeatures();
    return 1;
  }

  serProperty() async {
    BienDetailsEndPoint bienDetailsEndPoint = BienDetailsEndPoint();
    AuthController authController = Get.find();

    ajoutBienFormModel.value = AjoutBienFormModel.fromJson(
        await bienDetailsEndPoint.getProperty(
            ajoutBienFormModel.value.id, authController.token));
    return 1;
  }

  setSelectedPic(int i) {
    if (selectedPic == null)
      selectedPic = i.obs;
    else
      selectedPic.value = i;
    update(['pictureSelected']);
  }

  setPhoto(File image) async {
    EstimationEndPoint estimationEndPoint = EstimationEndPoint();
    AuthController authController = Get.find();
    Map<String, dynamic> body = await estimationEndPoint.uploadFile(
        ajoutBienFormModel.value.id, authController.token, image);
    print(body.toString());

    ajoutBienFormModel.value.fileBiens = await estimationEndPoint
        .getPropertyFiles(authController.token, ajoutBienFormModel.value.id);
  }

  setFeatures() {
    feat = [ajoutBienFormModel.value.surface.toString() + ' m²'];

    if (ajoutBienFormModel.value.sallon == true) feat.add('Sallon');
    if (ajoutBienFormModel.value.cuisine == true) feat.add('Cuisine');
    if (ajoutBienFormModel.value.terasse == true) feat.add('Terrasse');
    if (ajoutBienFormModel.value.garage == true) feat.add('Garage');
    if (ajoutBienFormModel.value.balcon == true) feat.add('Balcon');
    if (ajoutBienFormModel.value.jardin == true) feat.add('Jardin');
    if (ajoutBienFormModel.value.cave == true) feat.add('Cave');
    if (ajoutBienFormModel.value.piscine == true) feat.add('Piscine');
    feat.add('Depuis ' + ajoutBienFormModel.value.constructionDate.toString());
    feat.add('vue ' + ajoutBienFormModel.value.vue);
    feat.add(ajoutBienFormModel.value.standing + ' standing');
    feat.add('Emplacement ' + ajoutBienFormModel.value.emplacement);
    String export = "";
    if (ajoutBienFormModel.value.exportationNord == true)
      export = export + "Nord ";
    if (ajoutBienFormModel.value.exportationOuest == true)
      export = export + "Ouest ";
    if (ajoutBienFormModel.value.exportationEst == true)
      export = export + "Est ";
    if (ajoutBienFormModel.value.exportationSud == true)
      export = export + "Sud";
    feat.add(export);
  }

  Future<int> insertPrice() async {
    EstimationEndPoint estimationEndPoint = EstimationEndPoint();
    AuthController authController = Get.find();

    Response r = await estimationEndPoint.updateBien(
        ajoutBienFormModel.value.id,
        authController.token,
        ajoutBienFormModel.toJson());
    if (r.statusCode == 200) {
      ajoutBienFormModel.value.updatedAt =
          DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS").parse(r.body['updatedAt']);
      return 1;
    } else
      return 0;
  }

  insertDescription(String description) async {
    ajoutBienFormModel.value.description = description;
    EstimationEndPoint estimationEndPoint = EstimationEndPoint();
    AuthController authController = Get.find();
    Response r = await estimationEndPoint.updateBien(
        ajoutBienFormModel.value.id,
        authController.token,
        ajoutBienFormModel.toJson());
    return r.statusCode == 200;
  }

  setprogress(int prog) {
    progress.value = prog.toDouble();
  }

  setLocalisation(String localisation) {
    ajoutBienFormModel.value.localisation = localisation;
  }

  setConstructionDate(String constructionDate) {
    ajoutBienFormModel.value.constructionDate = constructionDate;
  }

  setSurface(double surface) {
    ajoutBienFormModel.value.surface = surface;
  }

  setSurfaceTerrain(double surface) {
    ajoutBienFormModel.value.surfaceTerrain = surface;
  }

  setSurfaceSejour(double surface) {
    ajoutBienFormModel.value.surfaceSejour = surface;
  }

  updateNbChambre(AddOrSub arith) {
    if (arith == AddOrSub.ADD)
      ajoutBienFormModel.value.nbChambre += 1;
    else
      ajoutBienFormModel.value.nbChambre -= 1;
    update();
  }

  updateNbParking(AddOrSub arith) {
    if (arith == AddOrSub.ADD)
      ajoutBienFormModel.value.nbParking += 1;
    else
      ajoutBienFormModel.value.nbParking -= 1;
    update();
  }

  updateNbPiece(AddOrSub arith) {
    if (arith == AddOrSub.ADD)
      ajoutBienFormModel.value.nbPiece += 1;
    else
      ajoutBienFormModel.value.nbPiece -= 1;
    update();
  }

  updateSelectedCategory(String category) {
    ajoutBienFormModel.value.category = category;
    update();
  }

  updateSelectedVue(String vue) {
    ajoutBienFormModel.value.vue = vue;
    update();
  }

  updateSelectedStanding(String standing) {
    ajoutBienFormModel.value.standing = standing;
    update();
  }

  updateSelectedEmplacement(String emplacement) {
    ajoutBienFormModel.value.emplacement = emplacement;
    update();
  }

  void toggleIsowner() {
    ajoutBienFormModel.value.isOwner = !ajoutBienFormModel.value.isOwner;
    update();
    print(ajoutBienFormModel.value.isOwner.toString());
  }

  toggleCuisine() {
    ajoutBienFormModel.value.cuisine = !ajoutBienFormModel.value.cuisine;
    update();
  }

  toggleSallon() {
    ajoutBienFormModel.value.sallon = !ajoutBienFormModel.value.sallon;
    update();
  }

  toggleTerasse() {
    ajoutBienFormModel.value.terasse = !ajoutBienFormModel.value.terasse;
    update();
  }

  toggleGarage() {
    ajoutBienFormModel.value.garage = !ajoutBienFormModel.value.garage;
    update();
  }

  toggleCave() {
    ajoutBienFormModel.value.cave = !ajoutBienFormModel.value.cave;
    update();
  }

  togglebalcon() {
    ajoutBienFormModel.value.balcon = !ajoutBienFormModel.value.balcon;
    update();
  }

  togglePiscine() {
    ajoutBienFormModel.value.piscine = !ajoutBienFormModel.value.piscine;
    update();
  }

  toggleJardin() {
    ajoutBienFormModel.value.jardin = !ajoutBienFormModel.value.jardin;
    update();
  }

  toggleFutureTraveaux() {
    ajoutBienFormModel.value.futureTraveaux =
        !ajoutBienFormModel.value.futureTraveaux;
    update();
  }

  toggleDependance() {
    ajoutBienFormModel.value.dependance = !ajoutBienFormModel.value.dependance;
    update();
  }

  toggleExportationNord() {
    ajoutBienFormModel.value.exportationNord =
        !ajoutBienFormModel.value.exportationNord;
    update();
  }

  toggleExportationSud() {
    ajoutBienFormModel.value.exportationSud =
        !ajoutBienFormModel.value.exportationSud;
    update();
  }

  toggleExportationEst() {
    ajoutBienFormModel.value.exportationEst =
        !ajoutBienFormModel.value.exportationEst;
    update();
  }

  toggleExportationOuest() {
    ajoutBienFormModel.value.exportationOuest =
        !ajoutBienFormModel.value.exportationOuest;
    update();
  }

  toggleMitoyen() {
    ajoutBienFormModel.value.mitoyen = !ajoutBienFormModel.value.mitoyen;
    update();
  }
}
