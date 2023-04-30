import 'package:flutter/material.dart';
import 'package:todo_list/models/place_location.dart';
import 'package:todo_list/screens/map_screen.dart';
import 'package:todo_list/services/location_service.dart';

class MapWidget extends StatelessWidget {
  const MapWidget({Key? key, required this.placeLocation}) : super(key: key);
  final PlaceLocation placeLocation;
  @override
  Widget build(BuildContext context) {
    String previewImageUrl = LocationService.generateMapUrlImage(
        placeLocation.latitude, placeLocation.longitude);
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (builder) => MapScreen(initialLocation: placeLocation),
          ),
        );
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          border: Border.all(width: 0.5),
          borderRadius: BorderRadius.circular(10),
        ),
        child: previewImageUrl.isEmpty
            ? Center(child: Text('Tap Untuk Menambah Lokasi'))
            : Image.network(previewImageUrl),
      ),
    );
  }
}
