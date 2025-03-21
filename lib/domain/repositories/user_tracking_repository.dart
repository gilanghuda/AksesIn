import 'package:aksesin/domain/entities/user_loc.dart';

abstract class UserTrackingRepository {
  Future<void> updateLocation(UserLocation location);
  Stream<UserLocation> trackUserById(String userId);
}
