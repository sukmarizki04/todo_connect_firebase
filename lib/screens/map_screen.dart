import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:todo_list/models/place_location.dart';
import 'package:todo_list/services/location_service.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key, required this.initialLocation}) : super(key: key);

  final PlaceLocation initialLocation;

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng _pickedLocation = LatLng(-6.1754, 106.8272);
  String _address = '';
  late GoogleMapController _googleMapController;

  Future getUserLocation() async {
    LocationData? locationData = await LocationService.getUserLocation();
    if (locationData != null) {
      setLocation(LatLng(locationData.latitude!, locationData.longitude!),
          moveCamera: true);
    }
  }

  Future setLocation(LatLng position, {bool moveCamera = false}) async {
    if (moveCamera)
      _googleMapController.moveCamera(CameraUpdate.newLatLng(position));
    setState(() {
      _pickedLocation = position;
      //address
    });
  }

  @override
  void initState() {
    if (widget.initialLocation.latitude == 0 &&
        widget.initialLocation.longitude == 0) {
      getUserLocation();
    } else {
      setLocation(
          LatLng(widget.initialLocation.latitude,
              widget.initialLocation.longitude),
          moveCamera: true);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_address),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: _pickedLocation,
          zoom: 13,
        ),
        markers: {
          Marker(
            markerId: MarkerId('pickedLocation'),
            position: _pickedLocation,
          ),
        },
        onMapCreated: (GoogleMapController googleMapController) {
          _googleMapController = googleMapController;
        },
        onTap: setLocation,
        myLocationEnabled: true,
      ),
    );
  }
}
