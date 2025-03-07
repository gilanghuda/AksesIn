
import 'package:aksesin/data/datasource/auth_service.dart';
import 'package:aksesin/domain/entities/user.dart';
import 'package:aksesin/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuthService firebaseAuthService;

  AuthRepositoryImpl(this.firebaseAuthService);

  @override
  Future<UserEntity> login(String email, String password) async {
    final user = await firebaseAuthService.login(email, password);
    return UserEntity(id: user.id, username: user.username, email: user.email);
  }

  @override
  Future<UserEntity> register(String email,String username, String password) async {
    final user = await firebaseAuthService.register(email,username, password);
    return UserEntity(id: user.id, username: username, email: user.email);
  }
}