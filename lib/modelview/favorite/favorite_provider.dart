import 'package:flutter/material.dart';
import '../../../cors/services/api_services.dart';
import '../../../cors/constant/api_end_point.dart';
import '../../model/favorite/favorite_post_response.dart';

class FavoriteProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();

  bool _isLoading = false;
  String? _errorMessage;
  FavoriteResponse? _favoriteResponse;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  FavoriteResponse? get favoriteResponse => _favoriteResponse;

  Future<bool> favoritePost(String postId) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      final response = await _apiService.post(
        ApiEndpoints.favoritePost(postId),
        data: {"post_id": postId},
      );

      _favoriteResponse = FavoriteResponse.fromJson(response.data);
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }
}
