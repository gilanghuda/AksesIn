import '../repositories/komunitas_repository.dart';
import '../entities/komunitas.dart';

class AddKomunitas {
  final KomunitasRepository repository;

  AddKomunitas(this.repository);

  Future<void> call(Komunitas komunitas) async {
    await repository.addKomunitas(komunitas);
  }
}
