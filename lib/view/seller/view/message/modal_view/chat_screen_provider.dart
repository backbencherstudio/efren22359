import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../../../cors/constant/api_end_point.dart';
import '../../../../../cors/services/token_storage.dart';
import '../../../../../cors/services/user_id_storage.dart';
import '../../../../../model/chat/category_based_conversation_model.dart';
import '../../../../../model/chat/category_conversation_metadata_model.dart';
import '../../../../../model/chat/getConversation_metadata.dart';
import '../../../../../model/chat/get_generale_coonversation_list_model.dart';
import '../../../model/message/conversation_detail_model.dart';
import '../../../model/message/message_detail_model.dart';

class ChatScreenProviderSeller extends ChangeNotifier {
  ChatScreenProviderSeller() {
    fetchConversationMetadata();
    fetchGeneralConversationList();
    fetchResponseConversationList();
  }

  final TokenStorage _tokenStorage = TokenStorage();
  final UserIdStorage _userIdStorage = UserIdStorage();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  GetConversationMetadata? _getConversationMetadata;
  GetConversationMetadata? get getConversationMetadata =>
      _getConversationMetadata;

  GeneraleConversationListModel? _generaleConversationListModel;
  GeneraleConversationListModel? get generaleConversationListModel =>
      _generaleConversationListModel;

  CategoryConversationMetaData? _categoryConversationMetaData;
  CategoryConversationMetaData? get categoryConversationMetaData =>
      _categoryConversationMetaData;

  CategoryBasedConversation? _categoryBasedConversation;
  CategoryBasedConversation? get categoryBasedConversation =>
      _categoryBasedConversation;

  MessageDetailModel? _messageDetailModel;
  MessageDetailModel? get messageDetailModel => _messageDetailModel;

  ConversationDetailModel? _conversationDetailModel;
  ConversationDetailModel? get conversationDetailModel =>
      _conversationDetailModel;

  Future<void> fetchConversationMetadata() async {
    final url = Uri.parse(ApiEndpoints.getConversationMetadata);
    try {
      _isLoading = true;
      notifyListeners();

      final token = await _tokenStorage.getToken();
      if (token == null) {
        debugPrint("Token missing. Cannot fetch metadata.");
        return;
      }

      final response = await http
          .get(url, headers: {'Authorization': 'Bearer $token'})
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        _getConversationMetadata = GetConversationMetadata.fromJson(data);
        debugPrint("Conversation Metadata fetched successfully");
      } else {
        debugPrint(
          "Failed to fetch conversation metadata: ${response.statusCode}",
        );
      }
    } catch (error) {
      debugPrint("Error fetching conversation metadata: $error");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchGeneralConversationList() async {
    final url = Uri.parse(ApiEndpoints.getGeneralConversationList);
    try {
      _isLoading = true;
      notifyListeners();

      final token = await _tokenStorage.getToken();
      if (token == null) {
        debugPrint("Token missing. Cannot fetch general conversations.");
        return;
      }

      final response = await http
          .get(url, headers: {'Authorization': 'Bearer $token'})
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        _generaleConversationListModel = GeneraleConversationListModel.fromJson(
          data,
        );
        debugPrint("General conversations fetched successfully");
        debugPrint(
          "Count: ${_generaleConversationListModel?.data?.length ?? 0}",
        );
      } else {
        debugPrint(
          "Failed to fetch general conversations: ${response.statusCode}",
        );
      }
    } catch (error) {
      debugPrint("Error fetching general conversations: $error");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchResponseConversationList() async {
    final url = Uri.parse(ApiEndpoints.getCategoryMetadata);
    try {
      _isLoading = true;
      notifyListeners();

      final token = await _tokenStorage.getToken();
      if (token == null) {
        debugPrint("Token missing. Cannot fetch response conversations.");
        return;
      }

      final response = await http
          .get(url, headers: {'Authorization': 'Bearer $token'})
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        _categoryConversationMetaData = CategoryConversationMetaData.fromJson(
          data,
        );
        debugPrint("Response conversations fetched successfully");
        debugPrint(
          "Count: ${_categoryConversationMetaData?.data?.length ?? 0}",
        );
      } else {
        debugPrint(
          "Failed to fetch response conversations: ${response.statusCode}",
        );
      }
    } catch (error) {
      debugPrint("Error fetching response conversations: $error");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> getCategoryBasedConversation(String serviceName) async {
    final url = Uri.parse(
      ApiEndpoints.getCategoryBasedConversation(serviceName),
    );
    try {
      _isLoading = true;
      notifyListeners();

      final token = await _tokenStorage.getToken();
      if (token == null) {
        debugPrint("Token missing. Cannot fetch category-based conversation.");
        return;
      }

      final response = await http
          .get(url, headers: {'Authorization': 'Bearer $token'})
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        _categoryBasedConversation = CategoryBasedConversation.fromJson(data);
        debugPrint("Category-based conversations fetched successfully");
      } else {
        debugPrint(
          "Failed to fetch category-based conversation: ${response.statusCode}",
        );
      }
    } catch (error) {
      debugPrint("Error fetching category-based conversation: $error");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> getChatMessage(String conversationId) async {
    final url = Uri.parse(ApiEndpoints.getConversationMessage(conversationId));
    try {
      _isLoading = true;
      notifyListeners();

      final token = await _tokenStorage.getToken();
      if (token == null) return false;

      final response = await http
          .get(
            url,
            headers: {
              'Authorization': 'Bearer $token',
              'Content-Type': 'application/json',
            },
          )
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        _messageDetailModel = MessageDetailModel.fromJson(data);
        debugPrint("Chat messages fetched successfully");
        return true;
      } else {
        debugPrint("Failed to fetch chat messages: ${response.statusCode}");
        return false;
      }
    } catch (error) {
      debugPrint("Error fetching chat messages: $error");
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> messageSend(
    String conversationId,
    String messageText,
    String image,
  ) async {
    debugPrint("The conversation Id is $conversationId");
    final url = Uri.parse(ApiEndpoints.sendMessage);

    try {
      _isLoading = true;
      notifyListeners();

      final token = await _tokenStorage.getToken();
      if (token == null) {
        debugPrint("Token missing. Cannot send message.");
        return;
      }

      final response = await http
          .post(
            url,
            headers: {
              "Content-Type": "application/json",
              "Authorization": "Bearer $token",
            },
            body: jsonEncode({
              "conversation_id": conversationId,
              "message": messageText,
              "attachments": image,
            }),
          )
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = jsonDecode(response.body);
        debugPrint("Message sent: $responseData");
      } else {
        final responseData = jsonDecode(response.body);
        debugPrint("Failed to send message: ${responseData['message']}");
        debugPrint(response.body);
      }
    } catch (error) {
      debugPrint("Error sending message: $error");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> conversationHeader(String conversationId) async {
    final url = Uri.parse(
      ApiEndpoints.conversationHeaderDetail(conversationId),
    );
    try {
      _isLoading = true;
      notifyListeners();

      final token = await _tokenStorage.getToken();
      if (token == null) return false;

      final response = await http
          .get(
            url,
            headers: {
              "Content-Type": "application/json",
              "Authorization": "Bearer $token",
            },
          )
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200 || response.statusCode == 201) {
        final decodeData = jsonDecode(response.body);
        _conversationDetailModel = ConversationDetailModel.fromJson(decodeData);
        debugPrint("Conversation header fetched successfully");
        return true;
      } else {
        debugPrint("Failed to fetch conversation header");
        return false;
      }
    } catch (error) {
      debugPrint("Error fetching conversation header: $error");
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> createServicesBasedConversation(
    String participantId,
    String postId,
  ) async {
    debugPrint("In the provider $participantId $postId");
    final url = Uri.parse(ApiEndpoints.createServiceBasedConversation);

    try {
      _isLoading = true;
      notifyListeners();

      final token = await _tokenStorage.getToken();
      if (token == null) {
        debugPrint("Token missing. Cannot create service-based conversation.");
        return;
      }

      final response = await http
          .post(
            url,
            headers: {
              "Authorization": "Bearer $token",
              "Content-Type": "application/json",
            },
            body: jsonEncode({
              "participant_id": participantId,
              "post_id": postId,
            }),
          )
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200 || response.statusCode == 201) {
        final decodeData = jsonDecode(response.body);
        debugPrint("The decode data is ${decodeData['message']}");
        debugPrint("Conversation created successfully");
      } else {
        final decodeData = jsonDecode(response.body);
        debugPrint(
          "Conversation creation failed: ${decodeData['message']}. ${response.body}",
        );
      }
    } catch (error) {
      debugPrint("Error creating service-based conversation: $error");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> createGeneralBasedConversation(String participantId) async {
    final url = Uri.parse(ApiEndpoints.createGeneralConversation);

    try {
      _isLoading = true;
      notifyListeners();

      final token = await _tokenStorage.getToken();
      if (token == null) {
        debugPrint("Token missing. Cannot create general conversation.");
        return;
      }

      final response = await http
          .post(
            url,
            headers: {
              "Authorization": "Bearer $token",
              "Content-Type": "application/json",
            },
            body: jsonEncode({"participant_id": participantId}),
          )
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200 || response.statusCode == 201) {
        final decodeData = jsonDecode(response.body);
        debugPrint("The decode data is ${decodeData['message']}");
        debugPrint("Conversation created successfully");
      } else {
        final decodeData = jsonDecode(response.body);
        debugPrint("Conversation creation failed: ${decodeData['message']}");
      }
    } catch (error) {
      debugPrint("Error creating general conversation: $error");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _getConversationMetadata = null;
    _generaleConversationListModel = null;
    _categoryConversationMetaData = null;
    _categoryBasedConversation = null;
    _messageDetailModel = null;
    _conversationDetailModel = null;
    super.dispose();
  }
}
