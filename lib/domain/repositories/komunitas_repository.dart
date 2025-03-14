import '../entities/komunitas.dart';

abstract class KomunitasRepository {
  Future<void> addKomunitas(Komunitas komunitas);
  Future<void> deleteKomunitas(String komunitasId);
  Future<void> updateKomunitas(Komunitas komunitas);
  Future<List<Komunitas>> getKomunitas(String kategory);
  Future<void> updateLikes(String komunitasId, int newLikesCount, String userId);
}
