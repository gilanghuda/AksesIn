import 'package:aksesin/domain/entities/komunitas.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class KomunitasModel extends Komunitas {
  KomunitasModel({
    required String id,
    required String userId,
    required String username,
    String? userProfileImage,
    required String content,
    required DateTime createdAt,
    int likesCount = 0,
    int commentsCount = 0,
    required List<String> commentText,
    List<String>? images,
    required String category,
    required List<String> likedBy,
  }) : super(
          id: id,
          userId: userId,
          username: username,
          userProfileImage: userProfileImage,
          content: content,
          createdAt: createdAt,
          likesCount: likesCount,
          commentsCount: commentsCount,
          commentText: commentText,
          images: images,
          category: category,
          likedBy: likedBy,
        );

  factory KomunitasModel.fromMap(Map<String, dynamic> map) {
    return KomunitasModel(
      id: map['id'],
      userId: map['userId'],
      username: map['username'],
      userProfileImage: map['userProfileImage'],
      content: map['content'],
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      likesCount: map['likesCount'],
      commentsCount: map['commentsCount'],
      commentText: List<String>.from(map['commentText']),
      images: map['images'] != null ? List<String>.from(map['images']) : null,
      category: map['category'],
      likedBy: List<String>.from(map['likedBy'] ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'username': username,
      'userProfileImage': userProfileImage,
      'content': content,
      'createdAt': createdAt,
      'likesCount': likesCount,
      'commentsCount': commentsCount,
      'commentText': commentText,
      'images': images,
      'category': category,
      'likedBy': likedBy,
    };
  }
}
