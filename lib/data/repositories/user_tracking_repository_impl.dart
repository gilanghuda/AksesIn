import 'package:aksesin/domain/entities/user_loc.dart';
import 'package:aksesin/domain/repositories/user_tracking_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:aksesin/data/models/user_loc_model.dart';

class UserTrackingRepositoryImpl implements UserTrackingRepository {
  final FirebaseFirestore firestore;

  UserTrackingRepositoryImpl(this.firestore);

  @override
  Future<void> updateLocation(UserLocation location) async {
    await firestore.collection('user_locations').doc(location.userId).set(UserLocationModel(
      userId: location.userId,
      latitude: location.latitude,
      longitude: location.longitude,
    ).toJson());
  }


  @override
  Stream<UserLocation> trackUserById(String userId) {
    return firestore.collection('user_locations').doc(userId).snapshots().map((doc) {
      final data = doc.data();
      if (data != null) {
        return UserLocationModel.fromJson(data);
      } else {
        return UserLocationModel(userId: userId, latitude: 0.0, longitude: 0.0);
      }
    });
  }
}
