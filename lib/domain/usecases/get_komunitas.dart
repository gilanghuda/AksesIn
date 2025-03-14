import '../repositories/komunitas_repository.dart';
import '../entities/komunitas.dart';

class GetKomunitas {
  final KomunitasRepository repository;

  GetKomunitas(this.repository);

  Future<List<Komunitas>> call(String category) async {
    return await repository.getKomunitas(category);
  }
}
