import 'package:aksesin/core/usecase/usecase.dart';
import 'package:aksesin/domain/entities/user.dart';
import '../repositories/auth_repository.dart';

class RegisterUser implements UseCase<UserEntity, RegisterParams> {
  final AuthRepository repository;

  RegisterUser(this.repository);

  @override
  Future<UserEntity> call(RegisterParams params) async {
    return await repository.register(params.email, params.username, params.password, params.disabilityOptions);
  }
}

class RegisterParams {
  final String email;
  final String username;
  final String password;
  final List<String> disabilityOptions;

  RegisterParams({required this.email, required this.username, required this.password, required this.disabilityOptions});
}