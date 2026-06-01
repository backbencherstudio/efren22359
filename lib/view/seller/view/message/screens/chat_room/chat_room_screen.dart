import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:local/cors/constant/api_end_point.dart';
import 'package:local/cors/services/user_id_storage.dart';
import 'package:provider/provider.dart';
import '../../../../../../cors/constant/app_colors.dart';
import '../../../../../../cors/constant/app_icons.dart';
import '../../../../model/message/message_detail_model.dart';
import '../../modal_view/chat_screen_provider.dart';

class ChatRoomScreen extends StatefulWidget {
  const ChatRoomScreen({super.key});

  @override
  State<ChatRoomScreen> createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  final TextEditingController messageController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  String conversationId = "";
  String? currentUserId;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // Get user id from storage
      currentUserId = await UserIdStorage().getUserId();

      final args = ModalRoute.of(context)?.settings.arguments as Map?;
      if (args != null && args['conversationId'] != null) {
        conversationId = args['conversationId'];
        final provider = Provider.of<ChatScreenProviderSeller>(
          context,
          listen: false,
        );
        provider.getChatMessage(conversationId);
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    messageController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  void sendMessage(ChatScreenProviderSeller provider) async {
    final text = messageController.text.trim();
    if (text.isEmpty || currentUserId == null) return;

    final newMessage = Messages(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      message: text,
      createdAt: DateTime.now().toIso8601String(),
      senderId: currentUserId,
      isRead: true,
    );

    setState(() {
      provider.messageDetailModel?.data?.messages?.add(newMessage);
    });

    messageController.clear();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent + 60,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });

    if (conversationId.isNotEmpty) {
      try {
        await provider.messageSend(conversationId, text, "");
        debugPrint("Message sent to server successfully");
      } catch (e) {
        debugPrint("Error sending message to server: $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ChatScreenProviderSeller>(context);
    final messages = provider.messageDetailModel?.data?.messages ?? [];
    final headerData = provider.conversationDetailModel?.data;

    // ✅ Determine which avatar to show based on current user
    String? avatarUrl;
    String displayName = "Unknown User";
    String availability = "No availability info";

    if (headerData != null && currentUserId != null) {
      if (currentUserId == headerData.creator?.id.toString()) {
        // If current user is the creator → show participant info
        avatarUrl = headerData.participant?.avatar;
        displayName = headerData.participant?.name ?? "Unknown User";
        availability = headerData.participant?.availability ?? "No info";
      } else if (currentUserId == headerData.participant?.id.toString()) {
        // If current user is the participant → show creator info
        avatarUrl = headerData.creator?.avatar;
        displayName = headerData.creator?.name ?? "Unknown User";
        availability = headerData.creator?.availability ?? "No info";
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
        titleSpacing: 0,
        centerTitle: false,
        title: Row(
          children: [
            ClipOval(
              child:
                  (avatarUrl != null && avatarUrl.isNotEmpty)
                      ? Image.network(
                        "${ApiEndpoints.imageBaseurl}/public/storage/avatar/$avatarUrl",
                        width: 40,
                        height: 40,
                        fit: BoxFit.cover,
                        errorBuilder:
                            (context, error, stackTrace) => Image.asset(
                              "assets/images/profile.png",
                              width: 40,
                              height: 40,
                            ),
                      )
                      : Image.asset(
                        "assets/images/profile.png",
                        width: 40,
                        height: 40,
                      ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    displayName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    availability,
                    style: const TextStyle(fontSize: 13, color: Colors.grey),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            children: [
              SizedBox(height: 56.h),

              Expanded(
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[index];
                    final isCurrentUser = message.senderId == currentUserId;
                    final timestamp =
                        message.createdAt != null
                            ? DateTime.parse(message.createdAt!)
                            : DateTime.now();
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 4.h),
                      child: Column(
                        crossAxisAlignment:
                            isCurrentUser
                                ? CrossAxisAlignment.end
                                : CrossAxisAlignment.start,
                        children: [
                          Text(
                            DateFormat('hh:mm a').format(timestamp),
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 10.h,
                              horizontal: 14.w,
                            ),
                            decoration: BoxDecoration(
                              color:
                                  isCurrentUser
                                      ? AppColors.primaryColor
                                      : AppColors.fieldColor,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20.r),
                                topRight: Radius.circular(20.r),
                                bottomLeft:
                                    isCurrentUser
                                        ? Radius.circular(20.r)
                                        : Radius.zero,
                                bottomRight:
                                    isCurrentUser
                                        ? Radius.zero
                                        : Radius.circular(20.r),
                              ),
                            ),
                            child: Text(
                              message.message ?? "",
                              style: TextStyle(
                                color:
                                    isCurrentUser
                                        ? Colors.white
                                        : Colors.black87,
                                fontSize: 14.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),

              SizedBox(height: 8.h),

              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: messageController,
                      onSubmitted: (_) => sendMessage(provider),
                      decoration: InputDecoration(
                        hintText: 'Type message...',
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(12.w),
                          child: SvgPicture.asset(AppIcons.emojiIcon),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.r),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: AppColors.fieldColor,
                      ),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  GestureDetector(
                    onTap: () => sendMessage(provider),
                    child: CircleAvatar(
                      radius: 24.r,
                      backgroundColor: AppColors.primaryColor,
                      child: const Icon(Icons.send, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
