import 'dart:convert';

import 'package:location/location.dart';
import 'package:http/http.dart' as http;

const GOOGLE_API_KEY = '';

class LocationService {
  static Future<LocationData?> getUserLocation() async {
    Location location = Location();
    bool serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) return null;
    }
    PermissionStatus permissionStatus = await location.hasPermission();
    if (permissionStatus == PermissionStatus.denied) {
      permissionStatus = await location.requestPermission();
      if (permissionStatus == PermissionStatus.denied) return null;
    }
    return location.getLocation();
  }

  static String generateMapUrlImage(double latitude, double longitude) {
    if (latitude == 0 || longitude == 0) return '';
    return '';
  }

  static Future<String> getPlaceAddress(
      double latitude, double longitude) async {
    final url = '';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final results = json.decode(response.body);
      if (results['results'].length > 0) {
        return results['results'][0]['formatted_address'];
      }
    }
    return '';
  }
}
