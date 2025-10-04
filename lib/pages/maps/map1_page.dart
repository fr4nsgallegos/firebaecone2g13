import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Map1Page extends StatelessWidget {
  const Map1Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GoogleMap(
          initialCameraPosition: CameraPosition(
            target: LatLng(-12.031869, -76.926042),
            zoom: 12,
          ),
          markers: {
            Marker(
              markerId: MarkerId("1"),
              position: LatLng(-12.031869, -76.926042),
            ),
          },
        ),
      ),
    );
  }
}
