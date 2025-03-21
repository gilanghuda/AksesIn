import '../entities/user.dart';

abstract class AuthRepository {
  Future<UserEntity> login(String email, String password);
  Future<UserEntity> register(String email, String username, String password, List<String> disabilityOptions);
  Future<void> updateProfile(String username, String email, String? photoUrl);
}