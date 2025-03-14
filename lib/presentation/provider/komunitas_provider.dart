import 'package:flutter/material.dart';
import '../../domain/entities/komunitas.dart';
import '../../domain/usecases/get_komunitas.dart';
import '../../domain/usecases/add_komunitas.dart';
import '../../domain/usecases/update_komunitas.dart';

class KomunitasProvider with ChangeNotifier {
  final GetKomunitas getKomunitas;
  final AddKomunitas addKomunitas;
  final UpdateKomunitas updateKomunitas;

  KomunitasProvider({
    required this.getKomunitas,
    required this.addKomunitas,
    required this.updateKomunitas,
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
}
