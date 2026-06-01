import 'package:flutter/material.dart';

class ChatResponseProvider extends ChangeNotifier {
  final List responseList = ['Services', 'Jobs', 'For_sale', 'Help','Gigs','Community'];
  final List conversationCountList = ['4', '1', '8', '8'];

  String? _selectedResponse;

  String? get selectedResponse => _selectedResponse;

  bool _isResponseChatRoom = false;

  bool get isResponseChatRoom => _isResponseChatRoom;

  void setSelectedUser(String response) {
    _selectedResponse = response;
    notifyListeners();
  }

  void setIsResponseChatRoom (bool type) {
    _isResponseChatRoom = type;
    notifyListeners();
  }
}