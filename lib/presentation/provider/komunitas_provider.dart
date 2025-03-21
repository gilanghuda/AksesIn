import 'package:flutter/material.dart';
import '../../domain/entities/komunitas.dart';
import '../../domain/usecases/get_komunitas.dart';
import '../../domain/usecases/add_komunitas.dart';
import '../../domain/usecases/update_komunitas.dart';

class KomunitasProvider with ChangeNotifier {
  final GetKomunitas getKomunitas;
  final AddKomunitas addKomunitas;
  final UpdateKomunitas updateKomunitas;
  final GetKomunitas getComments; 

  KomunitasProvider({
    required this.getKomunitas,
    required this.addKomunitas,
    required this.updateKomunitas,
    required this.getComments, 
  });

  List<Komunitas> _komunitasList = [];
  List<Komunitas> get komunitasList => _komunitasList;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> fetchKomunitas(String category) async {
    _isLoading = true;
    notifyListeners();

    _komunitasList = await getKomunitas(category);

    _isLoading = false;
    notifyListeners();
  }

  Future<void> addNewKomunitas(Komunitas komunitas) async {
    await addKomunitas(komunitas);
    _komunitasList.add(komunitas);
    notifyListeners();
  }

  Future<void> updateLikes(String komunitasId, int newLikesCount, String userId) async {
    await updateKomunitas.updateLikes(komunitasId, newLikesCount, userId);
    final index = _komunitasList.indexWhere((komunitas) => komunitas.id == komunitasId);
    if (index != -1) {
      final updatedLikedBy = List<String>.from(_komunitasList[index].likedBy)..add(userId);
      _komunitasList[index] = _komunitasList[index].copyWith(likesCount: newLikesCount, likedBy: updatedLikedBy);
      notifyListeners();
    }
  }

  Future<void> unlikeKomunitas(String komunitasId, int newLikesCount, String userId) async {
    await updateKomunitas.unlikekomunitas(komunitasId, newLikesCount, userId);
    final index = _komunitasList.indexWhere((komunitas) => komunitas.id == komunitasId);
    if (index != -1) {
      final updatedLikedBy = List<String>.from(_komunitasList[index].likedBy)..remove(userId);
      _komunitasList[index] = _komunitasList[index].copyWith(likesCount: newLikesCount, likedBy: updatedLikedBy);
      notifyListeners();
    }
  }

  Future<void> addComment(String komunitasId, String comment) async {
    await updateKomunitas.addComment(komunitasId, comment);
    final index = _komunitasList.indexWhere((komunitas) => komunitas.id == komunitasId);
    if (index != -1) {
      final updatedComments = List<String>.from(_komunitasList[index].commentText)..add(comment);
      _komunitasList[index] = _komunitasList[index].copyWith(commentText: updatedComments, commentsCount: _komunitasList[index].commentsCount + 1);
      notifyListeners();
    }
  }

  Future<void> deleteComment(String komunitasId, String comment) async {
    await updateKomunitas.deleteComment(komunitasId, comment);
    final index = _komunitasList.indexWhere((komunitas) => komunitas.id == komunitasId);
    if (index != -1) {
      final updatedComments = List<String>.from(_komunitasList[index].commentText)..remove(comment);
      _komunitasList[index] = _komunitasList[index].copyWith(commentText: updatedComments, commentsCount: _komunitasList[index].commentsCount - 1);
      notifyListeners();
    }
  }

  Future<List<String>> fetchComments(String komunitasId) async {
    return await getComments.getComments(komunitasId); 
  }

}
