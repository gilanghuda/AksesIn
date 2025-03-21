import 'package:aksesin/domain/entities/user_loc.dart';
import 'package:aksesin/domain/repositories/user_tracking_repository.dart';

class TrackUserById {
  final UserTrackingRepository repository;

  TrackUserById(this.repository);

  Stream<UserLocation> call(String userId) {
    return repository.trackUserById(userId);
  }
}
