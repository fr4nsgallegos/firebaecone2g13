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
      myPositionMarker = Marker(
        markerId: MarkerId("myPosition"),
        position: LatLng(position.latitude, position.longitude),
      );
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
        child: GoogleMap(
          initialCameraPosition: CameraPosition(
            target: currentPosition != null
                ? LatLng(currentPosition!.latitude, currentPosition!.longitude)
                : LatLng(-12.031869, -76.926042),
            zoom: 12,
          ),
          markers: {
            // Marker(
            //   markerId: MarkerId("1"),
            //   position: LatLng(-12.031869, -76.926042),
            // ),
            if (myPositionMarker != null) myPositionMarker!,
          },
        ),
      ),
    );
  }
}
