import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:local/cors/constant/api_end_point.dart';
import 'package:local/cors/routes/routes_name.dart';
import 'package:provider/provider.dart';
import '../modal_view/chat_screen_provider.dart';

class MessageCard extends StatelessWidget {
  const MessageCard({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ChatScreenProviderSeller>(context);
    final conversation = provider.generaleConversationListModel?.data?[index];

    debugPrint("The index in general is $index");

    if (conversation == null) {
      debugPrint("Conversation at index $index is null");
      return const SizedBox.shrink();
    }

    final name = conversation.participant?.name ?? "Unknown User";
    final avatarUrl = conversation.participant?.avatar ?? '';
    final lastMessage = conversation.lastMessage?.message ?? 'No message';
    final createdAt = conversation.createdAt ?? '';
    final conversationId = conversation.id;
    final participantId = conversation.participantId;

    debugPrint(" MessageCard Loaded:");
    debugPrint("  → participantId: $participantId");
    debugPrint("  → conversationId: $conversationId");

    return GestureDetector(
      onTap: () async {
        try {
          if (conversationId == null || conversationId.isEmpty) {
            debugPrint(" Conversation ID is missing — cannot open chat");
            return;
          }

          debugPrint("🔄 Opening chat for conversationId: $conversationId");

          // Fetch conversation header and chat messages safely
          provider.conversationHeader(conversationId);
          provider.getChatMessage(conversationId);

          // Navigate only if context is still mounted
          if (context.mounted) {
            Navigator.pushNamed(
              context,
              RouteName.chatRoomScreen,
              arguments: {"conversationId": conversationId},
            );
          }

          debugPrint("✅ Chat opened successfully for $conversationId");
        } catch (e, st) {
          debugPrint("❌ Error while opening chat: $e");
          debugPrint(st.toString());
          if (context.mounted) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text("Error: $e")));
          }
        }
      },
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage:
              avatarUrl.isNotEmpty
                  ? NetworkImage(
                    "${ApiEndpoints.imageBaseurl}/public/storage/avatar/$avatarUrl",
                  )
                  : const AssetImage('assets/images/default_avatar.png')
                      as ImageProvider,
          radius: 24,
        ),
        title: Text(name, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(
          lastMessage,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Text(
          createdAt.isNotEmpty
              ? DateFormat('hh:mm a').format(DateTime.parse(createdAt))
              : '',
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
      ),
    );
  }
}
