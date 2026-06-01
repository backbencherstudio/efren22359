import 'package:flutter/material.dart';
import 'package:local/cors/services/api_services.dart';
import 'package:local/cors/services/user_id_storage.dart';
import 'package:local/model/my_post/my_post_model.dart';

import '../../cors/constant/api_end_point.dart';

class MyPostDetailsProvider extends ChangeNotifier {
  bool _isLoading = false;
  String _errorMessage = '';

  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  List<MyPostModel> _myPostList = [];
  List<MyPostModel> get myPostList => _myPostList;

  final ApiService _apiService = ApiService();

  Future<void> getMyPostList() async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _apiService.get(ApiEndpoints.getUserPostsDetailsList);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final rawData = response.data;

        if (rawData is List) {
          _myPostList = rawData
              .map((e) => MyPostModel.fromJson(e as Map<String, dynamic>))
              .toList();
        } else {
          _myPostList = [];
          debugPrint("Unexpected response format: $rawData");
        }

        _errorMessage = '';
        debugPrint("The my post length is: ${_myPostList.length}");
      } else {
        _errorMessage = 'Failed to fetch my post';
      }
    } catch (e) {
      debugPrint("Error: $e");
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}