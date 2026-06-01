import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:local/cors/constant/api_end_point.dart';
import 'package:local/model/chat/get_all_user_model.dart';

import '../../cors/services/token_storage.dart';

class AllUserProvider extends ChangeNotifier {
  final TokenStorage _tokenStorage = TokenStorage();

  late AllUserModel _allUserMode;
  AllUserModel get allUserMode => _allUserMode;

  Future<void> getAllUser() async {
    final url = Uri.parse(ApiEndpoints.getAllUser);

    try {
      final token = await _tokenStorage.getToken();

      final response = await http.get(
        url,
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = json.decode(response.body);

        _allUserMode = AllUserModel.fromJson(data);

        debugPrint("fetch the all user successfully");
        debugPrint("The response body is ${response.body}");
      }
    } catch (error) {
      debugPrint("The error message is $error");
    }
  }
}
