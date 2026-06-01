import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:local/cors/constant/api_end_point.dart';
import 'package:local/cors/services/token_storage.dart';
import 'package:http/http.dart' as http;

import '../../model/home/parent_category_model.dart';
import '../../model/home/sub_category_model.dart';

class HomeCategoryProvider extends ChangeNotifier {
  HomeCategoryProvider() {
    getParentCategory();
  }

  String? selectedCategory;
  String? selectedSubCategory;

  final TokenStorage _tokenStorage = TokenStorage();

  List<dynamic> _parentCategory = [];

  List<dynamic> get parentCategory => _parentCategory;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> getParentCategory() async {
    _isLoading = true;
    notifyListeners();
    final url = Uri.parse(ApiEndpoints.parentCategory);
    try {
      final token = await _tokenStorage.getToken();

      final response = await http.get(
        url,
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final categoryData = json.decode(response.body);
        _parentCategory =
            categoryData
                .map((data) => ParentCategoryModel.fromJson(data))
                .toList();

        debugPrint("The response data is category ${_parentCategory[0].title}");

        debugPrint("The response data is ${response.body}");
        debugPrint(
          "The parent category fetch successfully ${_parentCategory.length}",
        );
        _isLoading = false;
        notifyListeners();
      } else {
        debugPrint("Somthing Wrong");
        _isLoading = false;
        notifyListeners();
      }
    } catch (e) {
      debugPrint("Error: $e");
      _isLoading = false;
      notifyListeners();
    }
  }

  List<SubCategoryModel> _subCategoryList = [];
  List<SubCategoryModel> get subCategoryList => _subCategoryList;

  bool _isSubCategoryLoading = false;
  bool get isSubCategoryLoading => _isSubCategoryLoading;

  Future<void> getSubCategory(String parentId) async {
    _isSubCategoryLoading = true;
    notifyListeners();
    final url = Uri.parse(ApiEndpoints.subCategory(parentId));
    try {
      final token = await _tokenStorage.getToken();

      final response = await http.get(
        url,
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final categoryData = json.decode(response.body) as List;
        _subCategoryList = categoryData
            .map((data) => SubCategoryModel.fromJson(data))
            .toList();

        debugPrint("✅ First subcategory: ${_subCategoryList[0].title}");
        _isSubCategoryLoading = false;
        notifyListeners();
      } else {
        debugPrint("❌ Error: ${response.statusCode}");
        _isSubCategoryLoading = false;
        notifyListeners();
      }
    } catch (e) {
      debugPrint("❌ Error: $e");
      _isSubCategoryLoading = false;
      notifyListeners();
    }
  }

}
