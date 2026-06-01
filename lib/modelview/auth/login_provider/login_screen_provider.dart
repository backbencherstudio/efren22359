import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:convert';

import '../../../cors/constant/api_end_point.dart';
import '../../../cors/services/socket_services.dart';
import '../../../cors/services/token_storage.dart';
import '../../../cors/services/user_email_storage.dart';
import '../../../cors/services/user_id_storage.dart';
import '../../../cors/services/user_name_storage.dart';
import '../../../model/user/user_model.dart';
import '../../../view/seller/view/message/modal_view/chat_screen_provider.dart';

class LoginScreenProvider extends ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;
  final TokenStorage _tokenStorage = TokenStorage();
  final UserIdStorage _userIdStorage = UserIdStorage();
  final UserNameStorage _userNameStorage = UserNameStorage();
  final UserEmailStorage _userEmailStorage = UserEmailStorage();
  final SocketService _socketService = SocketService();

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  UserModel? _user;
  UserModel? get user => _user;

  // =====================================================
  // LOGIN METHOD WITH CHAT FETCHING
  // =====================================================
  Future<bool> login(
    BuildContext context,
    String email,
    String password,
  ) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final url = Uri.parse(ApiEndpoints.login);

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);

        //  Save token
        final token = data['authorization']['token'];
        await _tokenStorage.saveToken(token);
        debugPrint("Authorization token: $token");

        // Fetch user details
        await getMe();

        //  Connect socket
        _socketService.connect(token: token);
        if (_socketService.isConnected) {
          debugPrint("Socket connection successful!");
        }
        _socketService.emit('create_room', {'roomName': 'user_support_room'});

        //  FETCH ALL CHAT DATA after login success
        final chatProvider = Provider.of<ChatScreenProviderSeller>(
          context,
          listen: false,
        );

        // 🔹 Sequentially fetch required chat data
        await chatProvider.fetchConversationMetadata();
        await chatProvider.fetchGeneralConversationList();
        await chatProvider.fetchResponseConversationList();

        debugPrint(" All chat data fetched successfully after login.");

        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        _isLoading = false;
        _errorMessage = 'Login failed: ${response.statusCode}';
        debugPrint(_errorMessage);
        notifyListeners();
        return false;
      }
    } catch (error) {
      _isLoading = false;
      _errorMessage = ': $error';
      debugPrint(_errorMessage);
      notifyListeners();
      return false;
    }
  }

  // =====================================================
  // LOGOUT USER
  // =====================================================
  Future<void> logoutUser(BuildContext context) async {
    try {
      _isLoading = true;
      notifyListeners();

      await _tokenStorage.clearToken();
      await _userIdStorage.clearUserId();
      await _userNameStorage.clearUserName();
      _user = null;

      // Disconnect socket
      _socketService.disconnect();
      debugPrint("Socket disconnected");

      // Clear chat provider state if needed
      final chatProvider = Provider.of<ChatScreenProviderSeller>(
        context,
        listen: false,
      );
      // chatProvider.clearState(); // (Add clearState() in your ChatScreenProviderSeller if needed)

      debugPrint(" Logged out successfully, all data cleared");
    } catch (error) {
      debugPrint("Error during logout: $error");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // =====================================================
  // FETCH USER INFO
  // =====================================================
  Future<void> getMe() async {
    final getMeUrl = Uri.parse(ApiEndpoints.getMe);

    try {
      final token = await _tokenStorage.getToken();
      if (token == null) {
        debugPrint("Token missing. Cannot fetch user data.");
        return;
      }

      final response = await http.get(
        getMeUrl,
        headers: {
          'Authorization': 'Bearer $token',
          'Cache-Control': 'no-cache',
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final userData = jsonDecode(response.body);
        final userId = userData['data']['id'];
        _user = UserModel.fromJson(userData['data']);

        await _userIdStorage.saveUserId(userId.toString());
        await _userNameStorage.saveUserName(_user?.name ?? 'N/A');

        debugPrint("User data fetched: Name=${_user?.name}, ID=$userId");
      } else {
        debugPrint("Failed to fetch user data: ${response.statusCode}");
      }
    } catch (e) {
      debugPrint("Error fetching user data: $e");
    } finally {
      notifyListeners();
    }
  }
}
