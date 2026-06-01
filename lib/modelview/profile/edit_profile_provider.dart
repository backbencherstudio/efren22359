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

class EditProfileProvider extends ChangeNotifier {
  String? _message;
  String? get message => _message;

  void setMessage(String message) {
    _message = message;
    notifyListeners();
  }

  File? image;
  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage() async {
    final pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );
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

  Future<bool> updateProfile(String name, String phone_number, String gender, String dob, String about, String first_name, String last_name, String address, List<String> selectedSkills) async {
    _isLoading = true;
    notifyListeners();

    final url = Uri.parse(ApiEndpoints.updateUser);

    try {
      final accessToken = await tokenStorage.getToken();
      if (accessToken == null) {
        debugPrint('Access token not found. Cannot add item.');
        return false;
      }

      final request = http.MultipartRequest('PATCH', url);
      request.headers['Authorization'] = 'Bearer $accessToken';

      request.fields['name'] = name;
      request.fields['phone_number'] = phone_number;
      request.fields['gender'] = gender;
      request.fields['date_of_birth'] = dob;
      request.fields['about'] = about;
      request.fields['first_name'] = first_name;
      request.fields['last_name'] = last_name;
      // request.fields['country'] = country;
      // request.fields['state'] = state;
      // request.fields['city'] = city;
      // request.fields['zip_code'] = zip_code;
      request.fields['address'] = address;
      // request.fields['experience'] = experience;
      for (int i = 0; i < selectedSkills.length; i++) {
        request.fields['experience[$i]'] = selectedSkills[i];
      }

      if (image != null) {
        debugPrint('Uploading image...');
        String? mimeType = lookupMimeType(image!.path);
        String filename = path.basename(image!.path);
        request.files.add(
          await http.MultipartFile.fromPath(
            'image',
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
        final jsonData = jsonDecode(responseBody);
        final String onlyMessage = jsonData['message'];
        setMessage(onlyMessage);
        debugPrint(onlyMessage);
        return true;
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
}
