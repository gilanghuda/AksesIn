import 'package:aksesin/data/models/komunitas_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class KomunitasFirestoreService {
  final CollectionReference _komunitasCollection = FirebaseFirestore.instance.collection('komunitas');

  Future<void> addKomunitas(KomunitasModel komunitas) {
    return _komunitasCollection.doc(komunitas.id).set(komunitas.toMap());
  }

  Future<void> updateKomunitas(KomunitasModel komunitas) {
    return _komunitasCollection.doc(komunitas.id).update(komunitas.toMap());
  }

  Future<void> deleteKomunitas(String id) {
    return _komunitasCollection.doc(id).delete();
  }

  Future<void> addComment(String komunitasId, String comment) {
    return _komunitasCollection.doc(komunitasId).update({
      'commentText': FieldValue.arrayUnion([comment]),
      'commentsCount': FieldValue.increment(1),
    });
  }

  Future<void> deleteComment(String komunitasId, String comment) {
    return _komunitasCollection.doc(komunitasId).update({
      'commentText': FieldValue.arrayRemove([comment]),
      'commentsCount': FieldValue.increment(-1),
    });
  }

  Future<List<String>> fetchCommentsById(String komunitasId) async {
    DocumentSnapshot doc = await _komunitasCollection.doc(komunitasId).get();
    if (doc.exists) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      return List<String>.from(data['commentText']);
    } else {
      return [];
    }
  }

  Future<void> updateLikes(String komunitasId, int newLikesCount, String userId) {
    return _komunitasCollection.doc(komunitasId).update({
      'likesCount': newLikesCount,
      'likedBy': FieldValue.arrayUnion([userId]),
    });
  }

  Future<void> unlikeKomunitas(String komunitasId, int newLikesCount, String userId) {
    return _komunitasCollection.doc(komunitasId).update({
      'likesCount': newLikesCount,
      'likedBy': FieldValue.arrayRemove([userId]),
    });
  }


  Stream<List<KomunitasModel>> getKomunitas() {
    return _komunitasCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => KomunitasModel.fromMap(doc.data() as Map<String, dynamic>)).toList();
    });
  }
}
