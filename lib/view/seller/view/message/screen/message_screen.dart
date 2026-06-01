import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:local/cors/constant/app_colors.dart';
import 'package:local/view/seller/view/message/widget/message_filter_bottom_sheet.dart';
import 'package:local/view/seller/view/message/widget/message_screen_app_bar.dart';
import 'package:local/view/widget/custom_search_field.dart';
import 'package:provider/provider.dart';

import '../modal_view/chat_screen_provider.dart';
import '../widget/chat_response_card.dart';
import '../widget/message_card.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final chatScreenProviderSeller = Provider.of<ChatScreenProviderSeller>(
      context,
    );

    debugPrint(
      'chatScreenProviderSeller.getConversationMetadata?.data?.generals ${chatScreenProviderSeller.getConversationMetadata?.data?.generals}',
    );
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            children: [
              const MessageScreenAppBar(),
              CustomSearchField(bottomSheet: const MessageFilterBottomSheet()),
              SizedBox(height: 20.h),

              Expanded(
                child:
                    chatScreenProviderSeller.isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : DefaultTabController(
                          length: 2,
                          child: Column(
                            children: [
                              //  Tab Bar
                              TabBar(
                                labelColor: AppColors.primaryColor,
                                unselectedLabelColor: AppColors.darkTextColor,
                                indicatorColor: AppColors.primaryColor,
                                indicatorSize: TabBarIndicatorSize.tab,
                                indicatorWeight: 1.5,
                                tabs: [
                                  Tab(
                                    text:
                                        'General Messages (${chatScreenProviderSeller.getConversationMetadata?.data?.generals ?? 0}) ',
                                  ),
                                  Tab(
                                    text:
                                        'Ad Responses (${chatScreenProviderSeller.getConversationMetadata?.data?.adResponses ?? 0} )',
                                  ),
                                ],
                              ),
                              SizedBox(height: 16.h),
                              //  Tab Views
                              Expanded(
                                child: TabBarView(
                                  children: [
                                    _buildGeneral(context),
                                    _buildAllResponse(context),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.08),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGeneral(BuildContext context) {


    return Consumer<ChatScreenProviderSeller>(


      builder: (_, chatProvider, __) {
        return ListView.separated(
          itemCount:
          chatProvider.generaleConversationListModel?.data?.length ?? 0,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                debugPrint(
                  "The length generale is ${chatProvider.generaleConversationListModel?.data?.length ?? 0}",
                );
              },
              child: MessageCard(index: index),
            );
          },
          separatorBuilder: (context, index) => const Divider(),
        );
      },
    );
  }

  Widget _buildAllResponse(BuildContext context) {
    return Consumer<ChatScreenProviderSeller>(
      builder: (_, provider, __) {
        return ListView.separated(
          itemCount: provider.categoryConversationMetaData!.data?.length ?? 0,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {},
              child: ChatResponseCard(index: index),
            );
          },
          separatorBuilder: (context, index) => const Divider(),
        );
      },
    );
  }
}
