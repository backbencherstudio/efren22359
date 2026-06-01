import 'package:flutter/material.dart';
import '../../cors/constant/api_end_point.dart';
import '../../cors/services/api_services.dart';
import '../../model/home/disable_account.dart';

class AccountProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();

  bool _isLoading = false;
  bool _isDisabled = false;
  String? _message;

  bool get isLoading => _isLoading;
  bool get isDisabled => _isDisabled;
  String? get message => _message;

  Future<bool> disableAccount() async {
    try {
      _isLoading = true;
      _message = null;
      notifyListeners();

      final response = await _apiService.post(ApiEndpoints.disableAccount);

      final result = DisableAccountResponse.fromJson(response.data);

      debugPrint('perfectly verified $response');

      if (result.success) {
        _isDisabled = !_isDisabled;
        _message = _isDisabled
            ? "Account disabled successfully"
            : "Account reactivated successfully";
        return true;
      } else {
        _message = result.message;
        return false;
      }
    } catch (e) {
      _message = "Something went wrong: $e";
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
