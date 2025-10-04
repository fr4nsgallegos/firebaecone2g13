import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Map1Page extends StatefulWidget {
  Map1Page({super.key});

  @override
  State<Map1Page> createState() => _Map1PageState();
}

class _Map1PageState extends State<Map1Page> {
  Position? currentPosition;

  Marker? myPositionMarker;
  Set<Marker> markers = {};
  BitmapDescriptor? _customMarker;

  Future<void> _setCustomMarker() async {
    _customMarker = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(size: Size(48, 48)),
      'assets/markers/orange.png',
    );
    markers.add(
      Marker(
        markerId: MarkerId(markers.length.toString()),
        position: LatLng(currentPosition!.latitude, currentPosition!.longitude),
        icon: _customMarker!,
        infoWindow: InfoWindow(
          title: "Marcador personalizado",
          snippet: "Ubicación en Lima",
        ),
      ),
    );
  }

  Future<void> getPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Permisos denegados');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
        'Los permisos están denegados permanentemente, no podemos solicitar permisos.',
      );
    }

    try {
      Position position = await Geolocator.getCurrentPosition();
      print('Lat: ${position.latitude}, Lng: ${position.longitude}');
      currentPosition = position;
      // myPositionMarker = Marker(
      //   markerId: MarkerId("myPosition"),
      //   position: LatLng(position.latitude, position.longitude),
      // );
      // markers.add(myPositionMarker!);
      _setCustomMarker();
      setState(() {});
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    getPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: currentPosition == null
            ? CircularProgressIndicator()
            : GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: LatLng(
                    currentPosition!.latitude,
                    currentPosition!.longitude,
                  ),
                  zoom: 12,
                ),
                onTap: (LatLng latlng) {
                  Marker newMarker = Marker(
                    markerId: MarkerId(markers.length.toString()),
                    position: latlng,
                    infoWindow: InfoWindow(
                      title: "Marcador: ${markers.length}",
                      snippet:
                          "Lat: ${latlng.latitude}, Lng: ${latlng.longitude}",
                    ),
                  );
                  markers.add(newMarker);
                  setState(() {});
                },
                markers: markers,
                //  {
                // Marker(
                //   markerId: MarkerId("1"),
                //   position: LatLng(-12.031869, -76.926042),
                // ),
                // if (myPositionMarker != null) myPositionMarker!,
                // },
              ),
      ),
    );
  }
}
