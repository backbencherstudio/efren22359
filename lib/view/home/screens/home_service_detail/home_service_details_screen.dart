import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:local/cors/constant/api_end_point.dart';
import 'package:local/cors/constant/app_colors.dart';
import 'package:local/cors/routes/routes_name.dart';
import 'package:local/cors/utils/custom_bottom_report_model_sheet.dart';
import 'package:local/modelview/home/service_detail_provider.dart';
import 'package:local/view/widget/custom_item_app_bar.dart';
import 'package:provider/provider.dart';
import '../../../../cors/constant/app_icons.dart';
import '../../../../modelview/favorite/favorite_provider.dart';
import '../../../../modelview/home/get_all_post_screen_provider.dart';
import '../../../seller/view/message/modal_view/chat_screen_provider.dart';
import '../../../seller/view/my_add_seller/widgets/ad_rejection_widget.dart';
import '../../../seller/view_model/my_ad_provider.dart';

class HomeServiceDetailsScreen extends StatelessWidget {
  const HomeServiceDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final getAllPostScreenProvider = Provider.of<GetAllPostScreenProvider>(
      context,
    );

    final postDetail = getAllPostScreenProvider.postDetail;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomItemAppBar(
        title: postDetail?.category?.title ?? "N/A",
        hasSearch: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                SizedBox(height: 10.h),
                if (postDetail?.status == "rejected")
                  Column(
                    children: [
                      Text(
                        "Your Ad is Rejected!",
                        style: TextStyle(
                          color: AppColors.rejectionTextColor,
                          fontSize: 18.sp, // Scaled font size
                          fontWeight: FontWeight.bold, // Bold font weight
                        ),
                      ),
                      SizedBox(
                        height: 12.h,
                      ), // Space between the text and widget
                      AdRejectionWidget(
                        rejectionReason: postDetail?.rejectedReason ?? "",
                      ),
                      SizedBox(height: 16.h),
                    ],
                  ),
                SizedBox(height: 10.h),
                SizedBox(
                  height: 200.h,
                  width: double.infinity,
                  child: PageView.builder(
                    itemCount: 3,
                    onPageChanged: (index) {
                      Provider.of<ServiceDetailProvider>(
                        context,
                        listen: false,
                      ).updatePage(index);
                    },
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12.r),
                          child: Image.network(
                            "${ApiEndpoints.imageBaseurl}/public/storage${postDetail?.thumbnail}",
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade300,
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.broken_image,
                                    color: Colors.grey,
                                    size: 50.sp,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 12.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    3,
                    (index) => AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      margin: EdgeInsets.symmetric(horizontal: 4),
                      height: 7.h,
                      width:
                          context.watch<ServiceDetailProvider>().currentPage ==
                                  index
                              ? 28.w
                              : 15.w,
                      decoration: BoxDecoration(
                        color:
                            context
                                        .watch<ServiceDetailProvider>()
                                        .currentPage ==
                                    index
                                ? Color(0xff5D18EB)
                                : Color(0xffEBEBEB),
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildTagContainer(
                          postDetail?.category?.title ?? "N/A",
                        ),
                        GestureDetector(
                          onTap:
                              () =>
                                  CustomBottomReportModelSheet.showReportBottomSheet(
                                    context,
                                    postDetail?.id ?? '',
                                  ),
                          child: Icon(Icons.more_horiz),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      postDetail?.title ?? "N/A",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.darkTextColor,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        Image.asset(AppIcons.locationIcon, scale: 2),
                        SizedBox(width: 4.w),
                        Text(
                          postDetail?.location ?? "N/A",
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.lightTextColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      "\$${postDetail?.price ?? "00"}",
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.darkTextColor,
                      ),
                    ),
                  ],
                ),
                _buildSeparator('Description'),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    postDetail?.description ?? "N/A",
                    style: TextStyle(
                      color: AppColors.lightTextColor,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                _buildSeparator('Tags'),
                Row(
                  spacing: 4.w,
                  children: [
                    _buildTagContainer('Modern'),
                    _buildTagContainer('Leather'),
                    _buildTagContainer('Sofa'),
                  ],
                ),
                _buildSeparator('Posted By'),
                GestureDetector(
                  onTap: () async {
                    await getAllPostScreenProvider.getOneUserDetailById(
                      postDetail!.user!.id ?? "",
                    );
                    if (postDetail.user!.id != null ||
                        postDetail.user!.id!.isNotEmpty) {
                      Navigator.pushNamed(
                        context,
                        RouteName.postCreatorProfile,
                        // arguments: {'userId': postDetail.user!.id}, //  Correct way to pass ID
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("User Id Not Found")),
                      );
                    }
                  },
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(8.w),
                        height: 48.h,
                        width: 48.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.fieldColor,
                        ),
                        child: Image.asset(AppIcons.profileIcon),
                      ),
                      SizedBox(width: 16.w),
                      Text(
                        postDetail?.user?.name ?? "N/A",
                        style: TextStyle(fontSize: 14.sp),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.h),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16.h),
                  decoration: BoxDecoration(
                    color: AppColors.fieldColor,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Contact Info:\n',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14.sp,
                          color: Colors.black87,
                        ),
                      ),
                      _buildRichText(
                        'Call: ',
                        postDetail?.user?.phone ?? 'N/A',
                      ),
                      SizedBox(height: 4.h),
                      _buildRichText("Email: ", postDetail?.user?.email ?? ''),
                    ],
                  ),
                ),

                SizedBox(height: 20.h),
                Row(
                  children: [
                    Consumer<ChatScreenProviderSeller>(
                      builder: (context, chatProvider, child) {
                        return Expanded(
                          child: GestureDetector(
                            onTap: () async {
                              await chatProvider
                                  .createServicesBasedConversation(
                                    postDetail?.user!.id ?? "",
                                    postDetail!.id ?? "",
                                  );

                              debugPrint("THE post and usr id ${  postDetail?.user!.id ?? "No"}. ${postDetail!.id ?? "No"}");
                              debugPrint(
                                'The user id is ${postDetail.user?.id}',
                              );
                              debugPrint('The post id is ${postDetail.title}');
                              debugPrint('The post id is ${postDetail.id}');
                            },
                            child: Container(
                              height: 48.h,
                              decoration: BoxDecoration(
                                color: AppColors.primaryColor,
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: Center(
                                child: Text(
                                  'Message',
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),

                    SizedBox(width: 16.w),
                    GestureDetector(
                      onTap: () async {
                        final provider = Provider.of<FavoriteProvider>(
                          context,
                          listen: false,
                        );

                        final success = await provider.favoritePost(
                          postDetail?.id ?? '',
                        );

                        if (success) {
                          await context.read<MyAdProvider>().getFavoritePost();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                provider.favoriteResponse?.message ??
                                    'Added post to favorite',
                              ),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                provider.errorMessage ?? 'Something went wrong',
                              ),
                            ),
                          );
                        }
                      },
                      child: Consumer<FavoriteProvider>(
                        builder: (context, provider, child) {
                          return Container(
                            padding: EdgeInsets.all(12.h),
                            height: 48.h,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(12.r),
                              border: Border.all(
                                color: Colors.grey.shade100,
                                width: 1.5,
                              ),
                            ),
                            child: Center(
                              child:
                                  provider.isLoading
                                      ? const SizedBox(
                                        width: 18,
                                        height: 18,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          color: Colors.red,
                                        ),
                                      )
                                      : Icon(
                                        Icons.favorite,
                                        color: AppColors.primaryColor,
                                      ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  RichText _buildRichText(title, value) {
    return RichText(
      text: TextSpan(
        style: TextStyle(color: Colors.black, fontSize: 16),
        children: [
          TextSpan(text: title),
          TextSpan(text: value, style: TextStyle(fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _buildTagContainer(String title) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(45.r),
        color: AppColors.fieldColor,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
        child: Text(
          title,
          style: TextStyle(
            color: AppColors.primaryColor,
            fontWeight: FontWeight.w600,
            fontSize: 10.sp,
          ),
        ),
      ),
    );
  }

  Widget _buildSeparator(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 8.h),
        Divider(),
        SizedBox(height: 8.h),
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14.sp,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 8.h),
      ],
    );
  }
}
