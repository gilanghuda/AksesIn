class Komunitas {
  final String id;
  final String userId;
  final String username;
  final String? userProfileImage;
  final String content;
  final DateTime createdAt;
  final int likesCount;
  final int commentsCount;
  final List<String> commentText;
  final List<String>? images;
  final String category;
  final List<String> likedBy;

  Komunitas({
    required this.id,
    required this.userId,
    required this.username,
    this.userProfileImage,
    required this.content,
    required this.createdAt,
    this.likesCount = 0,
    this.commentsCount = 0,
    required this.commentText,
    this.images,
    required this.category,
    required this.likedBy,
  });

  Komunitas copyWith({
    String? id,
    String? userId,
    String? username,
    String? userProfileImage,
    String? content,
    DateTime? createdAt,
    int? likesCount,
    int? commentsCount,
    List<String>? commentText,
    List<String>? images,
    String? category,
    List<String>? likedBy,
  }) {
    return Komunitas(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      username: username ?? this.username,
      userProfileImage: userProfileImage ?? this.userProfileImage,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      likesCount: likesCount ?? this.likesCount,
      commentsCount: commentsCount ?? this.commentsCount,
      commentText: commentText ?? this.commentText,
      images: images ?? this.images,
      category: category ?? this.category,
      likedBy: likedBy ?? this.likedBy,
    );
  }
}