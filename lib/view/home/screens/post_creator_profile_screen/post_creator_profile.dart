import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../../../cors/constant/app_colors.dart';
import '../../../../../cors/constant/api_end_point.dart';
import '../../../../modelview/home/get_all_post_screen_provider.dart';
import '../../../seller/view/message/modal_view/chat_screen_provider.dart';

class PostCreatorProfile extends StatelessWidget {
  const PostCreatorProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<GetAllPostScreenProvider>(context);
    final chatProfile = Provider.of<ChatScreenProviderSeller>(context);
    final userData = provider.userProfileDataModel?.data;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Post Creator Profile"),
        centerTitle: true,
        backgroundColor: AppColors.primaryColor,
      ),
      body:
          userData == null
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // ===== Profile Avatar + Info =====
                    Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color(0xffF6F8FA),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Avatar
                          Container(
                            height: 80.h,
                            width: 80.h,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.fieldColor,
                              image:
                                  userData.avatar != null
                                      ? DecorationImage(
                                        image: NetworkImage(
                                          "${ApiEndpoints.imageBaseurl}/public/storage/avatar/${userData.avatar}",
                                        ),
                                        fit: BoxFit.cover,
                                      )
                                      : null,
                            ),
                            child:
                                userData.avatar == null
                                    ? Icon(
                                      Icons.person,
                                      size: 40.sp,
                                      color: Colors.grey,
                                    )
                                    : null,
                          ),
                          SizedBox(width: 16.w),

                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  userData.name ?? "N/A",
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.darkTextColor,
                                  ),
                                ),
                                SizedBox(height: 6.h),
                                Row(
                                  children: [
                                    Icon(Icons.location_on_outlined),
                                    Text(
                                      userData.address ?? "No Email Provided",
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        color: Colors.grey.shade700,
                                      ),
                                    ),
                                  ],
                                ),

                                SizedBox(height: 12),
                                GestureDetector(
                                  onTap: () async {
                                    await chatProfile
                                        .createGeneralBasedConversation(
                                          userData.id ?? "",
                                        );
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Colors.black,
                                    ),
                                    child: Text(
                                      "Message",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 20.h),
                    Divider(color: Colors.grey.shade300),

                    // ===== Additional Info =====
                    _buildInfoRow(
                      "Phone",
                      userData.phoneNumber ?? "Not available",
                    ),
                    _buildInfoRow("Gender", userData.gender ?? "Not specified"),
                    _buildInfoRow("Address", userData.address ?? "No address"),
                    _buildInfoRow("City", userData.city ?? "Not available"),
                    _buildInfoRow(
                      "Country",
                      userData.country ?? "Not available",
                    ),
                    _buildInfoRow("Account Type", userData.type ?? "N/A"),

                    SizedBox(height: 20.h),

                    // ===== Joined / Updated Info =====
                    if (userData.createdAt != null)
                      Text(
                        "Joined: ${userData.createdAt}",
                        style: TextStyle(fontSize: 12.sp, color: Colors.grey),
                      ),
                    if (userData.updatedAt != null)
                      Text(
                        "Last Updated: ${userData.updatedAt}",
                        style: TextStyle(fontSize: 12.sp, color: Colors.grey),
                      ),
                  ],
                ),
              ),
    );
  }

  // ===== Helper widget =====
  Widget _buildInfoRow(String title, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: TextStyle(fontSize: 14.sp, color: Colors.grey[700]),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
