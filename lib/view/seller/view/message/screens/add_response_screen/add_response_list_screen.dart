import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:local/cors/constant/api_end_point.dart';
import 'package:local/cors/services/user_id_storage.dart';
import 'package:local/view/seller/view/message/modal_view/chat_screen_provider.dart';
import '../../../../../../cors/routes/routes_name.dart';

class AddResponseListScreen extends StatelessWidget {
  const AddResponseListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ChatScreenProviderSeller>(context);
    final conversationList = provider.categoryBasedConversation?.data ?? [];

    return FutureBuilder<String?>(
      future: UserIdStorage().getUserId(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final userId = snapshot.data;

        // Safely get the type name
        final typeName =
            conversationList.isNotEmpty
                ? (conversationList.first.type ?? "N/A")
                : "N/A";

        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new),
              onPressed: () => Navigator.pop(context),
            ),
            centerTitle: false,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Conversation",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                Text(
                  typeName,
                  style: const TextStyle(fontSize: 13, color: Colors.grey),
                ),
              ],
            ),
          ),
          body: SafeArea(
            child:
                provider.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : conversationList.isEmpty
                    ? const Center(child: Text("No conversations found"))
                    : ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: conversationList.length,
                      itemBuilder: (context, index) {
                        final conversation = conversationList[index];

                        final participant = conversation.participant;
                        final creator = conversation.creator;

                        final isParticipant = userId == participant?.id;
                        final isCreator = userId == creator?.id;

                        final chatUser = isParticipant ? creator : participant;

                        final createdAt = conversation.createdAt;
                        String formattedDate = '';
                        if (createdAt != null) {
                          try {
                            final parsedDate = DateTime.parse(createdAt);
                            formattedDate = DateFormat(
                              'MMM d',
                            ).format(parsedDate);
                          } catch (e) {
                            formattedDate = 'Unknown date';
                          }
                        }
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: GestureDetector(
                            onTap: () async {
                              final convId = conversation.id ?? "";

                              // await network call
                              provider.getChatMessage(convId);
                              provider.conversationHeader(convId);

                              // navigate after fetch
                              if (context.mounted) {
                                Navigator.pushNamed(
                                  context,
                                  RouteName.chatRoomScreen,
                                  arguments: {"conversationId": convId},
                                );
                              }
                            },

                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                //  Circular Avatar
                                ClipOval(
                                  child:
                                      chatUser?.avatar != null
                                          ? Image.network(
                                            "${ApiEndpoints.imageBaseurl}/public/storage/avatar/${chatUser!.avatar!}",
                                            width: 50,
                                            height: 50,
                                            fit: BoxFit.cover,
                                            errorBuilder: (
                                              context,
                                              error,
                                              stackTrace,
                                            ) {
                                              return Image.asset(
                                                "assets/images/profile.png",
                                                width: 50,
                                                height: 50,
                                                fit: BoxFit.cover,
                                              );
                                            },
                                          )
                                          : Image.asset(
                                            "assets/images/profile.png",
                                            width: 50,
                                            height: 50,
                                            fit: BoxFit.cover,
                                          ),
                                ),

                                const SizedBox(width: 12),

                                //  Name & Availability
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        chatUser?.name ?? 'Unknown User',
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        chatUser?.availability ??
                                            "No availability info",
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                //  Date
                                Text(
                                  formattedDate,
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
          ),
        );
      },
    );
  }
}
