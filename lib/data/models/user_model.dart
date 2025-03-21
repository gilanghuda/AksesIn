import 'package:aksesin/domain/entities/user.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.id,
    required super.username,
    required super.email,
    required super.disabilityOptions,
    super.photoUrl, 
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['uid'],
      username: json['username'],
      email: json['email'],
      disabilityOptions: List<String>.from(json['disabilityOptions'] ?? []),
      photoUrl: json['photoUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': id,
      'username': username,
      'email': email,
      'disabilityOptions': disabilityOptions,
      'photoUrl': photoUrl, 
    };
  }
}