import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';

import '../../../cors/constant/api_end_point.dart';
import '../../../cors/services/token_storage.dart';
import '../../model/home/post_detail_model.dart';

class EditPostProvider extends ChangeNotifier {
  String _selectedOption = '';

  String get selectedOption => _selectedOption;

  void selectOption(String option) {
    _selectedOption = option;
    notifyListeners();
  }

  String _selectedOptionId = '';

  String get selectedOptionId => _selectedOptionId;

  void selectOptionId(String option) {
    _selectedOptionId = option;
    notifyListeners();
  }

  String _subSelectedOption = '';

  String get subSelectedOption => _subSelectedOption;

  void subSelectOption(String option) {
    _subSelectedOption = option;
    notifyListeners();
  }

  String _subSelectedOptionId = '';

  String get subSelectedOptionId => _subSelectedOptionId;

  void subSelectOptionId(String option) {
    _subSelectedOptionId = option;
    notifyListeners();
  }

  String? _message;
  String? get message => _message;

  String _postId = '';
  String get postId => _postId;

  Future<void> setPostId(String postId) async {
    _postId = postId;
    notifyListeners();
  }

  void setMessage(String message) {
    _message = message;
    notifyListeners();
  }

  File? image;
  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    if (pickedFile != null) {
      image = File(pickedFile.path);
      notifyListeners();
    } else {
      debugPrint('No image selected.');
    }
  }

  bool _isLoading = false;
  bool _isUploaded = false;

  bool get isLoading => _isLoading;
  bool get isUploaded => _isUploaded;

  final tokenStorage = TokenStorage();

  Future<bool> editPost(String type, String title, String description, String price, String tags, String categoryId, String location) async {

    _isLoading = true;
    notifyListeners();

    final url = Uri.parse(ApiEndpoints.updatePost(_postId));

    try {
      final accessToken = await tokenStorage.getToken();
      if (accessToken == null) {
        debugPrint('Access token not found. Cannot add item.');
        return false;
      }

      final request = http.MultipartRequest('PUT', url);
      request.headers['Authorization'] = 'Bearer $accessToken';

      request.fields['type'] = type;
      request.fields['title'] = title;
      request.fields['description'] = description;
      request.fields['price'] = price;
      request.fields['tags'] = tags;
      request.fields['categoryId'] = categoryId;
      request.fields['location'] = location;

      if (image != null) {
        debugPrint('Uploading image...');
        String? mimeType = lookupMimeType(image!.path);
        String filename = path.basename(image!.path);
        request.files.add(
          await http.MultipartFile.fromPath(
            'thumbnail',
            image!.path,
            filename: filename,
            contentType: mimeType != null ? MediaType.parse(mimeType) : null,
          ),
        );

      } else {
        debugPrint('No image selected to upload.');
      }
      final response = await request.send();
      final responseBody = await response.stream.bytesToString();
      if (response.statusCode >= 200 && response.statusCode < 300) {
        debugPrint('Create post successfully. Status: ${response.statusCode}');
        debugPrint('Response Body: $responseBody');
        _isLoading = false;
        _isUploaded = true;
        notifyListeners();
        if (responseBody.contains('message')) {
          final Map<String, dynamic> jsonData = jsonDecode(responseBody);
          final String onlyMessage = jsonData['message'];
          setMessage(onlyMessage);
          print(responseBody);
          return false;
        } else {
          return true;
        }
      } else {
        debugPrint('Failed to add details. Status: ${response.statusCode}');
        debugPrint('Request URL: ${request.url}');
        debugPrint('Request Headers: ${request.headers}');
        debugPrint('Request Fields: ${request.fields}');
        debugPrint('Response Body: $responseBody');
        _isLoading = false;
        _isUploaded = false;
        notifyListeners();
        return false;
      }
    } catch (error) {
      debugPrint('Error adding details: $error');
      _isLoading = false;
      _isUploaded = false;
      notifyListeners();
      return false;
    }
  }

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  final TokenStorage _tokenStorage = TokenStorage();

  PostDetailModel? _postDetail;
  bool _isDetailLoading = false;

  PostDetailModel? get postDetail => _postDetail;
  bool get isDetailLoading => _isDetailLoading;

  Future<void> getPostDetail() async {
    _isDetailLoading = true;
    notifyListeners();

    final url = Uri.parse(ApiEndpoints.getOnePost(_postId));

    try {
      final token = await _tokenStorage.getToken();
      final response = await http.get(
        url,
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> responseData = json.decode(response.body);

        debugPrint("The response body is ${response.body}");
        debugPrint("The single data fetch successfully");

        _postDetail = PostDetailModel.fromJson(responseData);
      } else {
        _errorMessage = "Failed to load post detail";
      }
    } catch (error) {
      debugPrint("The error message is $error");
      _errorMessage = "Error: $error";
    } finally {
      _isDetailLoading = false;
      notifyListeners();
    }
  }
}

