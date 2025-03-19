import 'package:aksesin/domain/entities/user_loc.dart';

class UserLocationModel extends UserLocation {
  UserLocationModel({
    required String userId,
    required double latitude,
    required double longitude,
  }) : super(
          userId: userId,
          latitude: latitude,
          longitude: longitude,
        );

  factory UserLocationModel.fromJson(Map<String, dynamic> json) {
    // Log the JSON data for debugging
    print('UserLocationModel.fromJson: $json');

    return UserLocationModel(
      userId: json['userId'] ?? '',
      latitude: json['latitude']?.toDouble() ?? 0.0,
      longitude: json['longitude']?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}
