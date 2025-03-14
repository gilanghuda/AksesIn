import '../repositories/komunitas_repository.dart';

class UpdateKomunitas {
  final KomunitasRepository repository;

  UpdateKomunitas(this.repository);

  Future<void> updateLikes(String komunitasId, int newLikesCount, String userId) async {
    return await repository.updateLikes(komunitasId, newLikesCount, userId);
  }
}
