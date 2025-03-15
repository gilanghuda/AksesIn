import '../repositories/komunitas_repository.dart';

class UpdateKomunitas {
  final KomunitasRepository repository;

  UpdateKomunitas(this.repository);

  Future<void> updateLikes(String komunitasId, int newLikesCount, String userId) async {
    return await repository.updateLikes(komunitasId, newLikesCount, userId);
  }

  Future<void> addComment(String komunitasId, String comment) async {
    return await repository.addComment(komunitasId, comment);
  }

  Future<void> deleteComment(String komunitasId, String comment) async {
    return await repository.deleteComment(komunitasId, comment);
  }
}
