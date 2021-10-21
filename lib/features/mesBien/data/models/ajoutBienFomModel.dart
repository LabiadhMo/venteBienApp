import 'package:intl/intl.dart';

enum AddOrSub { ADD, SUB }

class AjoutBienFormModel {
  String description;
  bool isOwner;
  String localisation;
  int nbPiece;
  int nbChambre;
  int nbParking;
  bool cuisine;
  bool sallon;
  bool terasse;
  bool garage;
  bool cave;
  bool balcon;
  bool piscine;
  bool jardin;
  double surface;
  String constructionDate;
  bool futureTraveaux;
  double surfaceTerrain;
  double surfaceSejour;
  bool dependance;
  List propLikes;
  List fileBiens;
  String status;
  bool exportationNord;
  bool exportationSud;
  bool exportationEst;
  bool exportationOuest;
  bool mitoyen;
  String id;
  DateTime createdAt;
  DateTime updatedAt;
  String vue;
  String standing;
  String category;
  String emplacement;
  int price;
  String street;
  String city;
  String country;

  AjoutBienFormModel({
    this.street = "",
    this.city = "",
    this.country = "",
    this.description = 'desc',
    this.fileBiens = const [],
    this.propLikes = const [],
    this.price = 0,
    this.isOwner = false,
    this.category = 'MAISON',
    this.localisation = '10 rue AlbertMat - Virigneux 42140',
    this.nbPiece = 1,
    this.nbChambre = 1,
    this.nbParking = 1,
    this.cuisine = false,
    this.sallon = false,
    this.terasse = false,
    this.garage = false,
    this.cave = false,
    this.balcon = false,
    this.piscine = false,
    this.jardin = false,
    this.surface,
    this.constructionDate = '2012',
    this.futureTraveaux = false,
    this.surfaceTerrain,
    this.surfaceSejour,
    this.dependance = false,
    this.exportationNord = false,
    this.exportationSud = false,
    this.exportationEst = false,
    this.exportationOuest = false,
    this.vue = 'Dégagée',
    this.standing = 'Standard',
    this.mitoyen = false,
    this.emplacement = 'Calme',
    this.id,
    this.createdAt,
    this.updatedAt,
    this.status,
  });

  factory AjoutBienFormModel.fromJson(Map<String, dynamic> json) {
    return AjoutBienFormModel(
      price: json['price'],
      isOwner: json['owner'],
      category: json['typeofprop'],
      localisation: json['propLocation'],
      nbPiece: json['nbRooms'],
      nbChambre: json['nbBedrooms'],
      nbParking: json['nbParkingPlaces'],
      cuisine: json['piecesOfProperty']['hasCuisine'],
      sallon: json['piecesOfProperty']['hasSallon'],
      terasse: json['piecesOfProperty']['hasTerrasse'],
      garage: json['piecesOfProperty']['hasGarage'],
      cave: json['piecesOfProperty']['hasCave'],
      balcon: json['piecesOfProperty']['hasBalcon'],
      piscine: json['piecesOfProperty']['hasPiscine'],
      jardin: json['piecesOfProperty']['hasJardin'],
      surface: json['allArea'],
      description: json['description'],
      constructionDate: json['yearConstruction'],
      futureTraveaux: json['hasPlannedWork'],
      surfaceTerrain: json['homeArea'],
      surfaceSejour: json['livingArea'],
      dependance: json['hasDependancy'],
      exportationNord: json['propExport']['isNord'],
      exportationSud: json['propExport']['isSud'],
      exportationEst: json['propExport']['isEst'],
      exportationOuest: json['propExport']['isOuest'],
      vue: json['vueProp'],
      standing: json['propStanding'],
      mitoyen: json['adjoining'],
      emplacement: json['propLocation'],
      propLikes: json['proplikes'],
      fileBiens: json['fileBien'],
      status: json['status'],
      id: json['id'],
      street: json['address']['street'],
      city: json['address']['city'],
      country: json['address']['stateFull'],
      createdAt:
          DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS").parse(json['createdAt']),
      updatedAt:
          DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS").parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "typeofprop": category.toString(),
      "vueProp": vue.toString(),
      "propLocation": emplacement.toString(),
      "propStanding": standing.toString(),
      "allArea": surface,
      "homeArea": surfaceTerrain,
      "livingArea": surfaceSejour,
      "location": {"latitude": 0, "longitude": 0},
      "address": {
        "street": street,
        "zipCode": "string",
        "city": city,
        "stateFull": country
      },
      "hasDependancy": dependance,
      "description": description,
      "nbBedrooms": nbChambre,
      "nbRooms": nbPiece,
      "nbParkingPlaces": nbParking,
      "hasPlannedWork": futureTraveaux,
      "nbFloors": 2,
      "yearConstruction": constructionDate,
      "price": price,
      "piecesOfProperty": {
        "hasSallon": sallon,
        "hasCuisine": cuisine,
        "hasTerrasse": terasse,
        "hasGarage": garage,
        "hasBalcon": balcon,
        "hasJardin": jardin,
        "hasCave": cave,
        "hasPiscine": piscine
      },
      "propExport": {
        "isNord": exportationNord,
        "isSud": exportationSud,
        "isEst": exportationEst,
        "isOuest": exportationOuest
      },
      "owner": isOwner,
      "adjoining": mitoyen
    };
  }
}
