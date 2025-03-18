import 'package:flutter_polyline_points/flutter_polyline_points.dart';

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
}
