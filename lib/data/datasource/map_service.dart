import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapService {
  Future<PolylineResult> getRouteBetweenCoordinates(
    String apiKey,
    PointLatLng start,
    PointLatLng end,
    TravelMode travelMode,
  ) async {
    PolylinePoints polylinePoints = PolylinePoints();
    return await polylinePoints.getRouteBetweenCoordinates(
      apiKey,
      start,
      end,
      travelMode: travelMode,
    );
  }

  static Future<void> updateUserLocationInFirestore(Position position) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance.collection('user_locations').doc(user.uid).set({
        'latitude': position.latitude,
        'longitude': position.longitude,
      });
    }
  }

   Stream<LatLng> simulateLocationStream({LatLng? initialPosition}) async* {
    LatLng position =
        initialPosition ?? const LatLng(37.42796133580664, -122.085749655962);
    while (true) {
      await Future.delayed(const Duration(seconds: 2));
      position =
          LatLng(position.latitude + 0.0001, position.longitude + 0.0001);
      yield position;
    }
  }

  Future<Stream<LatLng>> getLiveLocationStream() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
    }
    return Geolocator.getPositionStream(
      locationSettings: LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10,
      ),
    ).map((position) => LatLng(position.latitude, position.longitude));
  }
}

