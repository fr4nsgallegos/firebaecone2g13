import 'package:google_maps_flutter/google_maps_flutter.dart';

class PlaceModel {
  int id;
  String name;
  String services;
  LatLng position;
  String urlImage;

  PlaceModel({
    required this.id,
    required this.name,
    required this.services,
    required this.position,
    required this.urlImage,
  });
}

List<PlaceModel> places = [
  PlaceModel(
    id: 1,
    name: "Catedral de Lima",
    services: "Visitas guiadas, eventos religiosos",
    position: LatLng(-12.046374, -77.042793),
    urlImage:
        "https://upload.wikimedia.org/wikipedia/commons/thumb/5/57/Lima_cathédrale.jpg/960px-Lima_cathédrale.jpg?20180604092010",
  ),
  PlaceModel(
    id: 2,
    name: "Parque Kennedy",
    services: "Áreas de picnic, eventos culturales",
    position: LatLng(-12.121420, -77.030487),
    urlImage:
        "https://upload.wikimedia.org/wikipedia/commons/3/36/Parque_Kennedy_-_Lima%2C_Peru.jpg",
  ),
  PlaceModel(
    id: 3,
    name: "Museo Larco",
    services: "Exposiciones permanentes y temporales",
    position: LatLng(-12.109657, -77.034831),
    urlImage:
        "https://upload.wikimedia.org/wikipedia/commons/thumb/c/c7/Lima_museo_larco.jpg/960px-Lima_museo_larco.jpg",
  ),
];
