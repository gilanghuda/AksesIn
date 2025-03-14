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

  Stream<List<KomunitasModel>> getKomunitas() {
    return _komunitasCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => KomunitasModel.fromMap(doc.data() as Map<String, dynamic>)).toList();
    });
  }
}
