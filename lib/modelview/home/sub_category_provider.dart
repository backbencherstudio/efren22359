import 'package:flutter/material.dart';

import '../../cors/constant/api_end_point.dart';
import '../../cors/services/api_services.dart';
import '../../model/home/sub_category_model.dart';

class SubCategoryProvider extends ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  final ApiService _apiService = ApiService();

  List<SubCategoryModel> _subCategoryList = [];
  List<SubCategoryModel> get subCategoryList => _subCategoryList;

  Future<void> getSubCategoryByParentId(String parentId) async {
    _isLoading = true;
    notifyListeners();
    try {
      final response = await _apiService.get(ApiEndpoints.subCategoryByParentId(parentId));
      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.data as List;
        _subCategoryList = data.map((e) => SubCategoryModel.fromJson(e)).toList();
        _errorMessage = response.data['message'];
        _isLoading = false;
        notifyListeners();
        debugPrint("The sub category length is: ${_subCategoryList.length}");
      } else {
        _errorMessage = 'Failed to fetch sub category';
        _isLoading = false;
        notifyListeners();
      }
    } catch (e) {
      _errorMessage = 'Error: $e';
      _isLoading = false;
      notifyListeners();
    }
  }
}