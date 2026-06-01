import 'package:flutter/material.dart';
import 'package:local/cors/constant/api_end_point.dart';
import 'package:local/cors/constant/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:local/cors/routes/routes_name.dart';
import 'package:local/view/widget/custom_mypost_card.dart';
import 'package:provider/provider.dart';
import '../../../../modelview/auth/login_provider/login_screen_provider.dart';
import '../../../../modelview/profile/my_post_details_provider.dart';
import '../seller_parent/widget/seller_parent_screen_widget.dart';

class SellerProfile extends StatefulWidget {
  const SellerProfile({super.key});

  @override
  State<SellerProfile> createState() => _SellerProfileState();
}

class _SellerProfileState extends State<SellerProfile> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await context.read<LoginScreenProvider>().getMe(); // Refresh user data after initialization
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<MyPostDetailsProvider>();
    return Consumer<LoginScreenProvider>(
        builder: (_, loginProvider, __) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(110),
              child: AppBar(
                toolbarHeight: 60.h,
                automaticallyImplyLeading: false,
                backgroundColor: AppColors.primaryColor,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(20),
                  ),
                ),
                title: const Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Text(
                    'Profile',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                centerTitle: false,
                actions: [
                  IconButton(
                    icon: Image.asset('assets/images/profilePic.png', width: 40.w),
                    onPressed: () {
                      Navigator.pushNamed(context, RouteName.generalSettingsScreen);
                    },
                  ),
                  // Settings icon
                  IconButton(
                    icon: Image.asset('assets/images/settings.png', width: 40.w),
                    onPressed: () {
                      Navigator.pushNamed(context, RouteName.profileSettings);
                    },
                  ),
                  const SizedBox(width: 8.0),
                ],
                flexibleSpace: Stack(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.vertical(
                          bottom: Radius.circular(20),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Transform.translate(
                            offset: const Offset(0.0, 40.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(90.r),
                              child: Container(
                                height: 100.w,
                                width: 100.w,
                                decoration: BoxDecoration(
                                  color: AppColors.fieldColor,
                                  shape: BoxShape.circle,
                                ),
                                child: Image.network(
                                  '${ApiEndpoints.imageBaseurl}/public/storage/avatar/${loginProvider.user?.avatar}',
                                  height: 100.w,
                                  width: 100.w,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return const Icon(Icons.broken_image_outlined, size: 40,);
                                  },
                                ),
                              ),
                            )
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            body: Padding(
              padding: EdgeInsets.only(top: 40.0.h, left: 20, right: 20),
              child: Center(
                  child: DefaultTabController(
                    length: 2,
                    child: Column(
                      children: [
                        Text(
                          loginProvider.user?.name ?? 'N/A',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          loginProvider.user?.address ?? 'N/A',
                          style: TextStyle(
                            color: const Color(0xFF777980),
                            fontSize: 16.sp,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        TabBar(
                          labelColor: AppColors.primaryColor,
                          unselectedLabelColor: AppColors.darkTextColor,
                          indicatorColor: AppColors.primaryColor,
                          indicatorSize: TabBarIndicatorSize.tab,
                          indicatorWeight: 1.5,
                          tabs: const [Tab(text: 'Post'), Tab(text: 'Info')],
                        ),
                        SizedBox(height: 16.0.h),
                        Expanded(
                          child: TabBarView(
                            children: [
                              _buildAllPosts(provider),
                              _buildUserBio(loginProvider)
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
              ),
            ),
            bottomNavigationBar: const SellerParentScreenWidget(),
          );
        }
    );
  }
  Widget _buildAllPosts(MyPostDetailsProvider provider) {
    if (provider.myPostList.isEmpty) {
      return Center(
        child: Text('No posts available', style: TextStyle(color: AppColors.darkTextColor, fontSize: 16.sp, fontWeight: FontWeight.bold),),
      );
    }
    return ListView.separated(
      shrinkWrap: true,
      itemCount: provider.myPostList.length,
      itemBuilder: (context, index) {
        final post = provider.myPostList[index];
        return CustomMyPostCard(post: post);
      },
      separatorBuilder: (context, index) => SizedBox(height: 8.0.h),
    );
  }

  Widget _buildUserBio(LoginScreenProvider loginProvider) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildSectionContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Bio',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16.sp,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.0.h),
                Text(
                  loginProvider.user?.about ?? 'N/A',
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: AppColors.lightTextColor,
                  ),
                ),
              ],
            ),
          ),
          _buildSectionContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Experience',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16.sp,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 8.0.h),
                Wrap(
                  spacing: 8.0.w,
                  runSpacing: 4.0.h,
                  children:
                  loginProvider.user?.experience.map((experience) {
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 6.h),
                      decoration: BoxDecoration(
                        color: Color(0xFFF6F8FA),
                        borderRadius: BorderRadius.circular(20.r),
                        border: Border.all(
                          color: Color(0xFFDFE1E7),
                        ),
                      ),
                      child: Text(
                        experience,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  }).toList() ?? [],
                ),
              ],
            ),
          ),
          _buildSectionContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Contact Info:\n',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16.sp,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                _buildRichText(
                  'Phone Number: ',
                  loginProvider.user?.phoneNumber ?? '',
                  Colors.black,
                ),
                SizedBox(height: 4.0.h),
                _buildRichText(
                  "Email Address: ",
                  loginProvider.user?.email ?? '',
                  Colors.black,
                ),
              ],
            ),
          ),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }

  Widget _buildRichText(String title, String value, Color color) {
    return RichText(
      text: TextSpan(
        style: TextStyle(fontSize: 16.0.sp, color: const Color(0xFF777980)),
        children: [
          TextSpan(
            text: title,
            style: const TextStyle(
              fontWeight: FontWeight.normal,
              color: Color(0xFF777980),
              fontSize: 16,
            ),
          ),
          TextSpan(
            text: value,
            style: const TextStyle(
              fontWeight: FontWeight.normal,
              color: Colors.black,
              fontSize: 17,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionContainer({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      margin: EdgeInsets.symmetric(vertical: 6.0.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0.r),
        border: Border.all(color: Colors.grey.shade100, width: 1.5),
      ),
      child: child,
    );
  }
}
