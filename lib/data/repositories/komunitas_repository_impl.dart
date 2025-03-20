import 'package:aksesin/data/datasource/komunitas_firestore_service.dart';
import 'package:aksesin/data/models/komunitas_model.dart';
import 'package:aksesin/domain/entities/komunitas.dart';
import 'package:aksesin/domain/repositories/komunitas_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class KomunitasRepositoryImpl implements KomunitasRepository {
  final KomunitasFirestoreService _firestoreService;
  final FirebaseFirestore firestore;

  KomunitasRepositoryImpl(this._firestoreService, this.firestore);

  @override
  Future<void> addKomunitas(Komunitas komunitas) {
    final komunitasModel = KomunitasModel(
      id: komunitas.id,
      userId: komunitas.userId,
      username: komunitas.username,
      userProfileImage: komunitas.userProfileImage,
      content: komunitas.content,
      createdAt: komunitas.createdAt,
      likesCount: komunitas.likesCount,
      commentsCount: komunitas.commentsCount,
      commentText: komunitas.commentText,
      images: komunitas.images,
      category: komunitas.category,
      likedBy: komunitas.likedBy 
    );
    return _firestoreService.addKomunitas(komunitasModel);
  }

  @override
  Future<void> updateKomunitas(Komunitas komunitas) {
    final komunitasModel = KomunitasModel(
      id: komunitas.id,
      userId: komunitas.userId,
      username: komunitas.username,
      userProfileImage: komunitas.userProfileImage,
      content: komunitas.content,
      createdAt: komunitas.createdAt,
      likesCount: komunitas.likesCount,
      commentsCount: komunitas.commentsCount,
      commentText: komunitas.commentText,
      images: komunitas.images,
      category: komunitas.category,
      likedBy: komunitas.likedBy 
    );
    return _firestoreService.updateKomunitas(komunitasModel);
  }

  @override
  Future<void> deleteKomunitas(String id) {
    return _firestoreService.deleteKomunitas(id);
  }

  @override
  Future<List<Komunitas>> getKomunitas(String category) async {
    QuerySnapshot snapshot;
    if (category == 'all') {
      snapshot = await firestore.collection('komunitas').get();
    } else {
      snapshot = await firestore.collection('komunitas').where('category', isEqualTo: category).get();
    }

    return snapshot.docs.map((doc) => KomunitasModel.fromMap(doc.data() as Map<String, dynamic>)).toList();
  }

  @override
  Future<void> updateLikes(String komunitasId, int newLikesCount, String userId) async {
    final docRef = firestore.collection('komunitas').doc(komunitasId);
    await docRef.update({
      'likesCount': newLikesCount,
      'likedBy': FieldValue.arrayUnion([userId]),
    });
  }

  @override
  Future<void> unlikeKomunitas(String komunitasId, int newLikesCount, String userId) async {
    final docRef = firestore.collection('komunitas').doc(komunitasId);
    await docRef.update({
      'likesCount': newLikesCount,
      'likedBy': FieldValue.arrayRemove([userId]),
    });
  }

  @override
  Future<void> addComment(String komunitasId, String comment) async {
    await _firestoreService.addComment(komunitasId, comment);
  }

  @override
  Future<void> deleteComment(String komunitasId, String comment) {
    return _firestoreService.deleteComment(komunitasId, comment);
  }

  @override
  Future<List<String>> fetchCommentsById(String komunitasId) async {
    return await _firestoreService.fetchCommentsById(komunitasId); 
  }
}
