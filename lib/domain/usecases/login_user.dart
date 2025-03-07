import 'package:aksesin/core/usecase/usecase.dart';
import 'package:aksesin/domain/entities/user.dart';
import '../repositories/auth_repository.dart';

class LoginUser implements UseCase<UserEntity, LoginParams> {
  final AuthRepository repository;

  LoginUser(this.repository);

  @override
  Future<UserEntity> call(LoginParams params) async {
    if (params.email.isEmpty || params.password.isEmpty) {
      throw Exception('Email and Password cannot be empty');
    }
    return repository.login(params.email, params.password);
  }
}

class LoginParams {
  final String email;
  final String password;

  const LoginParams({
    required this.email,
    required this.password,
  });
}