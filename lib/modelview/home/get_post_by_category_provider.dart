import 'package:flutter/material.dart';
import 'package:local/model/category/category_post_model.dart';

import '../../cors/constant/api_end_point.dart';
import '../../cors/services/api_services.dart';

class GetPostByCategoryProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _errorMessage = "";
  String get errorMessage => _errorMessage;

  final ApiService _apiService = ApiService();

  List<CategoryPostModel> _postList = [];
  List<CategoryPostModel> get postList => _postList;

  String _categoryName = "";
  String get categoryName => _categoryName;

  Future<void> setCategoryName(String name) async {
    _categoryName = name;
    notifyListeners();
  }

  Future<void> getPostsByCategory(String categoryId) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _apiService.get(ApiEndpoints.getPostsByCategoryId(categoryId));
      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.data as List;
        _postList = data.map((e) => CategoryPostModel.fromJson(e)).toList();
        debugPrint("The category post length is: ${_postList.length}");
        if (_postList.isEmpty) {
          _errorMessage = 'No posts found for this category';
        } else {
          _errorMessage = '';
        }
        _isLoading = false;
        notifyListeners();
      } else {
        _errorMessage = 'Failed to fetch category posts';
      }
    } catch (e) {
      _errorMessage = 'Error ok: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}