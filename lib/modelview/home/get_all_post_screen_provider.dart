import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:local/cors/constant/api_end_point.dart';
import 'package:local/cors/services/token_storage.dart';
import '../../model/home/all_post_model.dart';
import '../../model/home/parent_category_model.dart';
import '../../model/home/post_detail_model.dart';
import '../../view/seller/model/user_profile_model.dart';

class GetAllPostScreenProvider extends ChangeNotifier {
  final TokenStorage _tokenStorage = TokenStorage();

  // ======================== Variables ========================

  List<AllPostModel> _posts = [];
  bool _isLoading = false;
  String? _errorMessage;

  PostDetailModel? _postDetail;
  bool _isDetailLoading = false;

  ParentCategoryModel? _parentCategory;

  UserProfileDataModel? _userProfileDataModel;

  // ======================== Getters ========================

  List<AllPostModel> get posts => _posts;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  int get postsLength => _posts.length;

  PostDetailModel? get postDetail => _postDetail;
  bool get isDetailLoading => _isDetailLoading;

  ParentCategoryModel? get parentCategory => _parentCategory;

  UserProfileDataModel? get userProfileDataModel => _userProfileDataModel;

  // ======================== Constructor ========================
  GetAllPostScreenProvider() {
    getAllPost();
  }

  // ============================================================
  // =============== GET ALL POSTS ==============================
  // ============================================================

  Future<void> getAllPost() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final token = await _tokenStorage.getToken();
      if (token == null) {
        _errorMessage = 'Authentication token is missing';
        _isLoading = false;
        notifyListeners();
        return;
      }

      final url = Uri.parse(ApiEndpoints.getAllPost);
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        debugPrint(" All posts response: ${response.body}");

        final dynamic responseData = json.decode(response.body);

        if (responseData is List<dynamic>) {
          // Case 1: Response is a list
          _posts =
              responseData
                  .map((postJson) => AllPostModel.fromJson(postJson))
                  .toList();
        } else if (responseData is Map<String, dynamic>) {
          // Case 2: Response is a map with 'data' field
          if (responseData.containsKey('data') &&
              responseData['data'] != null) {
            _posts =
                (responseData['data'] as List<dynamic>)
                    .map((postJson) => AllPostModel.fromJson(postJson))
                    .toList();
          } else {
            _errorMessage = responseData['message'] ?? 'No posts found';
          }
        } else {
          _errorMessage = 'Unexpected response format';
        }
      } else {
        _errorMessage =
            'Failed to fetch posts: ${response.statusCode} - ${response.reasonPhrase}';
      }
    } catch (error, stackTrace) {
      _errorMessage = 'Error fetching posts: $error';
      debugPrint(" Exception in getAllPost: $error");
      debugPrint(stackTrace.toString());
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // ============================================================
  // =============== GET POST DETAIL ============================
  // ============================================================

  Future<void> getPostDetail(String postId) async {
    _isDetailLoading = true;
    notifyListeners();

    final url = Uri.parse(ApiEndpoints.getOnePost(postId));

    try {
      final token = await _tokenStorage.getToken();
      final response = await http.get(
        url,
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> responseData = json.decode(response.body);

        debugPrint(" Post detail response: ${response.body}");

        _postDetail = PostDetailModel.fromJson(responseData);
      } else {
        _errorMessage =
            "Failed to load post detail: ${response.statusCode} - ${response.reasonPhrase}";
      }
    } catch (error, stackTrace) {
      _errorMessage = "Error fetching post detail: $error";
      debugPrint(" Exception in getPostDetail: $error");
      debugPrint(stackTrace.toString());
    } finally {
      _isDetailLoading = false;
      notifyListeners();
    }
  }

  // ============================================================
  // =============== GET PARENT CATEGORY ========================
  // ============================================================

  Future<void> getParentCategory() async {
    final url = Uri.parse(ApiEndpoints.parentCategory);

    try {
      final token = await _tokenStorage.getToken();
      final response = await http.get(
        url,
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        _parentCategory = ParentCategoryModel.fromJson(responseData);
        debugPrint(" Parent category response: ${response.body}");
      } else {
        _errorMessage =
            "Failed to load parent categories: ${response.statusCode} - ${response.reasonPhrase}";
      }
    } catch (error, stackTrace) {
      _errorMessage = "Error fetching parent categories: $error";
      debugPrint(" Exception in getParentCategory: $error");
      debugPrint(stackTrace.toString());
    } finally {
      notifyListeners();
    }
  }

  // ============================================================
  // =============== GET ONE USER DETAIL ========================
  // ============================================================

  Future<void> getOneUserDetailById(String userId) async {
    final url = Uri.parse(ApiEndpoints.getOneUserById(userId));

    try {
      final token = await _tokenStorage.getToken();
      final response = await http.get(
        url,
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final decodeData = jsonDecode(response.body);
        _userProfileDataModel = UserProfileDataModel.fromJson(decodeData);

        debugPrint(" User data fetched: ${_userProfileDataModel!.data!.name}");
        debugPrint(" User data decoe by Id: $decodeData}");
        debugPrint(" User  Id: $userId}");
        debugPrint(" User  name: }");
        notifyListeners(); //  ADD THIS LINE
      } else {
        final decodeData = jsonDecode(response.body);
        debugPrint(" Failed: ${decodeData['message']}");
      }
    } catch (error) {
      debugPrint(" Error: $error");
    }
  }
}
