import 'package:flutter/material.dart';
import 'package:local/view/seller/model/message/chat_user_model.dart';
import 'package:local/view/seller/model/message/static_data/chat_user_data.dart';

class ChatUserProvider with ChangeNotifier {
  List<ChatUserModel> _chatUsersList = chatUsers;

  List<ChatUserModel> get chatUsersList => _chatUsersList;

  int get blockedUsersCount => _chatUsersList.where((user) => user.isBlocked == true).length;

  List<ChatUserModel> get blockedUserList => _chatUsersList.where((user) => user.isBlocked == true).toList();

  int get unblockedUsersCount => _chatUsersList.where((user) => user.isBlocked == false).length;

  List<ChatUserModel> get unblockedUserList => _chatUsersList.where((user) => user.isBlocked == false).toList();

  ChatUserModel? _selectedUser;

  ChatUserModel? get selectedUser => _selectedUser;

  void unblockUser(String userId) {
    final userToUnblock = _chatUsersList.firstWhere((user) => user.id == userId);
    userToUnblock.isBlocked = false;
    notifyListeners();
  }

  void setSelectedUser(ChatUserModel user) {
    _selectedUser = user;
    notifyListeners();
  }
}