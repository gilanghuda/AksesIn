import 'package:aksesin/domain/entities/user_loc.dart';
import 'package:aksesin/domain/repositories/user_tracking_repository.dart';

class UpdateUserLocation {
  final UserTrackingRepository repository;

  UpdateUserLocation(this.repository);

  Future<void> call(UserLocation location) async {
    return repository.updateLocation(location);
  }
}
