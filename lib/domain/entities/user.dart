class UserEntity {
  final String id;
  final String username;
  final String email;
  final List<String> disabilityOptions;
  final String? photoUrl; 

  UserEntity({
    required this.id,
    required this.username,
    required this.email,
    required this.disabilityOptions,
    this.photoUrl, 
  });
}