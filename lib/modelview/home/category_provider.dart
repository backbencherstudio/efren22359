import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../cors/constant/api_end_point.dart';
import '../../cors/services/token_storage.dart';
import '../../model/home/parent_category_model.dart';

class CategoryProvider extends ChangeNotifier {
  final TokenStorage _tokenStorage = TokenStorage();

  List<ParentCategoryModel> _parentCategory = [];
  bool _isLoading = false;
  String? _error;

  List<ParentCategoryModel> get parentCategory => _parentCategory;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> getParentCategory() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final token = await _tokenStorage.getToken();
      final url = Uri.parse(ApiEndpoints.parentCategory);
      final res = await http.get(
        url,
        headers: {
          if (token != null && token.isNotEmpty) 'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      if (res.statusCode == 200 || res.statusCode == 201) {
        final decoded = json.decode(res.body);

        final List<dynamic> rows = decoded is List
            ? decoded
            : (decoded is Map<String, dynamic> && decoded['data'] is List
            ? decoded['data'] as List
            : const <dynamic>[]);

        _parentCategory = rows
            .map((e) => ParentCategoryModel.fromJson(
          (e as Map).cast<String, dynamic>(),
        )).toList();
        debugPrint('Parent categories loaded: ${_parentCategory.length}');
      } else {
        _error = 'Failed to fetch categories (${res.statusCode})';
        _parentCategory = [];
      }
    } catch (e) {
      _error = 'Error: $e';
      _parentCategory = [];
    } finally {
      _isLoading = false;
      notifyListeners(); // trigger UI update
    }
  }

}
