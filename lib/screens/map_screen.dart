import 'dart:html';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:todo_list/models/place_location.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key, required this.initialLocation}) : super(key: key);

  final PlaceLocation initialLocation;

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng _pickedLocation = LatLng(-6.1754, 106.8272);
  String _address = '';

  Future getUserLocation() async {
    Location location = Location();
    bool serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) return null;
    }
    PermissionStatus permissionStatus = await location.hasPermission();
    location.getLocation();
  }

  @override
  void initState() {
    if (widget.initialLocation.latitude == 0 &&
        widget.initialLocation.longitude == 0) {
      getUserLocation();
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
