import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsProvider with ChangeNotifier {
  late Position _currentPosition;
  String _currentAddress = '';
  Set<Marker> markers = {};
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];

  Position get currentPosition => _currentPosition;
  String get currentAddress => _currentAddress;

  void setCurrentPosition(Position position) {
    _currentPosition = position;
    notifyListeners();
  }

  void setCurrentAddress(String address) {
    _currentAddress = address;
    notifyListeners();
  }

  void addMarker(Marker marker) {
    markers.add(marker);
    notifyListeners();
  }

  void addPolyline(Polyline polyline) {
    polylines[polyline.polylineId] = polyline;
    notifyListeners();
  }

  void clearMarkers() {
    markers.clear();
    notifyListeners();
  }

  void clearPolylines() {
    polylines.clear();
    notifyListeners();
  }

  void clearPolylineCoordinates() {
    polylineCoordinates.clear();
    notifyListeners();
  }
}
