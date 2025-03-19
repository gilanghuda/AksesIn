class UserLocation {
  final String userId;
  final double latitude;
  final double longitude;
  final bool sos;

  UserLocation({
    required this.userId,
    required this.latitude,
    required this.longitude,
    this.sos = false,
  });
}