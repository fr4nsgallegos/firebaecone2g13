import 'package:custom_info_window/custom_info_window.dart';
import 'package:firebaecone2g13/pages/maps/model_maps.dart/place_model.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Map2Page extends StatefulWidget {
  Map2Page({super.key});

  @override
  State<Map2Page> createState() => _Map2PageState();
}

class _Map2PageState extends State<Map2Page> {
  Set<Marker> markers = {};
  CustomInfoWindowController _customInfoWindowController =
      CustomInfoWindowController();

  Future<void> addMarkers() async {
    Set<Marker> auxMarkers = Set();

    BitmapDescriptor iconMarker = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(size: Size(48, 48)),
      'assets/markers/green.png',
    );

    // MÉTODO 1
    // auxMarkers = places.map((place) {
    //   return Marker(
    //     markerId: MarkerId(place.id.toString()),
    //     position: place.position,
    //     icon: iconMarker,
    //     infoWindow: InfoWindow(title: place.name, snippet: place.services),
    //   );
    // }).toSet();

    // METODO 2
    places.forEach((place) {
      auxMarkers.add(
        Marker(
          markerId: MarkerId(place.id.toString()),
          position: place.position,
          icon: iconMarker,
          // infoWindow: InfoWindow(title: place.name, snippet: place.services),
          onTap: () {
            _customInfoWindowController.addInfoWindow!(
              Container(
                width: 250,
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.blueAccent),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text("Hola"),
              ),
              place.position,
            );
          },
        ),
      );
    });

    markers = auxMarkers;
    print(markers.length);
    setState(() {});
  }

  @override
  void initState() {
    addMarkers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: (GoogleMapController controller) async {
              _customInfoWindowController.googleMapController = controller;
            },
            initialCameraPosition: CameraPosition(
              target: LatLng(-12.046374, -77.042793),
              zoom: 12,
            ),
            markers: markers,
            onTap: (LatLng position) {
              _customInfoWindowController.hideInfoWindow!();
            },
            onCameraMove: (position) {
              _customInfoWindowController.onCameraMove!();
            },
          ),
          CustomInfoWindow(
            controller: _customInfoWindowController,
            height: 150,
            width: 250,
            offset: 50,
          ),
        ],
      ),
    );
  }
}
