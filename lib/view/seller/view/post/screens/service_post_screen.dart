import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:local/model/home/sub_category_model.dart';
import 'package:local/modelview/home/sub_category_provider.dart';
import 'package:provider/provider.dart';
import '../../../../../cors/constant/app_colors.dart';
import '../../../../../modelview/home/get_all_post_screen_provider.dart';
import '../../../../../modelview/profile/my_post_details_provider.dart';
import '../../../view_model/my_ad_provider.dart';
import '../../../view_model/post_viewmodel.dart';
import '../bottom_sheet/post_published_bottom_sheet.dart';

class ServicePostScreen extends StatefulWidget {
  const ServicePostScreen({super.key});

  @override
  State<ServicePostScreen> createState() => _ServicePostScreenState();
}

class _ServicePostScreenState extends State<ServicePostScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _tagController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  bool _didInit = false;
  List<SubCategoryModel> _categories = [];
  String? _selectedTitle;
  String? _selectedId;
  String _selectedExpireAt = 'days_7';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_didInit) return;
    _didInit = true;

    final parentCategoryId = context.read<PostViewmodel>().selectedOptionId;
    final subProv = context.read<SubCategoryProvider>();

    final getAllPostScreenProvider = Provider.of<GetAllPostScreenProvider>(
      context,
    );

    subProv.getSubCategoryByParentId(parentCategoryId).then((_) {
      if (!mounted) return;
      setState(() {
        _categories = subProv.subCategoryList;
        if (_categories.isNotEmpty && _selectedTitle == null) {
          _selectedTitle = _categories.first.title;
        }
      });
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _tagController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<PostViewmodel>();

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: AppColors.darkTextColor,
            size: 24.w,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "${viewModel.selectedOption} Post",
          style: TextStyle(
            color: AppColors.darkTextColor,
            fontSize: 24.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Consumer<PostViewmodel>(
          builder: (context, viewModel, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //  Image Picker Section
                GestureDetector(
                  onTap: viewModel.pickImage,
                  child: Container(
                    width: double.infinity,
                    height: 180.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(
                        color: AppColors.textFieldBox,
                        width: 1.5.w,
                      ),
                    ),
                    child:
                        viewModel.image != null
                            ? ClipRRect(
                              borderRadius: BorderRadius.circular(12.r),
                              child: Image.file(
                                viewModel.image!,
                                width: double.infinity,
                                height: 180.h,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Center(
                                    child: Icon(
                                      Icons.broken_image,
                                      size: 50.w,
                                      color: AppColors.lightTextColor,
                                    ),
                                  );
                                },
                              ),
                            )
                            : Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.add_a_photo,
                                    size: 30.w,
                                    color: AppColors.primaryColor,
                                  ),
                                  SizedBox(height: 8.h),
                                  Text(
                                    "Add Image",
                                    style: TextStyle(
                                      color: AppColors.primaryColor,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                  ),
                ),
                SizedBox(height: 24.h),

                //  Text Fields
                _buildTextField("Title", _titleController),
                _buildTextField(
                  "Description",
                  _descriptionController,
                  maxLines: 3,
                ),
                _buildTextField(
                  viewModel.selectedOption == 'Job'
                      ? "Salary (optional)"
                      : "Price (optional)",
                  _priceController,
                ),
                _buildTextField("Tags (optional)", _tagController),

                //  Category Dropdown
                Text(
                  "Category",
                  style: TextStyle(
                    color: AppColors.darkTextColor,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 8.h),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _selectedId,
                      isExpanded: true,
                      icon: Icon(
                        Icons.keyboard_arrow_down,
                        color: AppColors.darkTextColor,
                      ),
                      style: TextStyle(
                        color: AppColors.darkTextColor,
                        fontSize: 16.sp,
                      ),
                      dropdownColor: Colors.white,
                      hint: const Text("Select a category"),
                      menuMaxHeight: 300.h,
                      onChanged: (String? newValue) {
                        if (newValue == null) return;
                        setState(() => _selectedId = newValue);

                        viewModel.subSelectOptionId(newValue);

                        final selected = _categories.firstWhere(
                          (i) => i.id == newValue,
                          orElse: () => SubCategoryModel(),
                        );
                        viewModel.subSelectOption(selected.title ?? '');
                      },
                      items:
                          _categories.map((s) {
                            return DropdownMenuItem<String>(
                              value: s.id ?? '',
                              child: Text(s.title ?? ''),
                            );
                          }).toList(),
                    ),
                  ),
                ),

                SizedBox(height: 24.h),

                _buildTextField("Location", _locationController),

                //  Expiry Dropdown (Passes Value)
                _buildExpireDropdown(),

                //  Checkboxes
                _buildCheckbox(
                  title: "Allow chat only",
                  value: viewModel.allowChatOnly,
                  onChanged: (v) => viewModel.setAllowChatOnly(v ?? false),
                ),
                _buildCheckbox(
                  title: "Show Contact Info",
                  value: viewModel.showChatInfo,
                  onChanged: (v) => viewModel.setShowChatInfo(v ?? false),
                ),

                SizedBox(height: 32.h),
                // final getAllPostScreenProvider =
                // context.read<GetAllPostScreenProvider>();
                //
                // final myAdProvider = context.read<MyAdProvider>();
                //
                // final myPostDetailsProvider =
                // context.read<MyPostDetailsProvider>();
                //
                // await getAllPostScreenProvider.getAllPost();
                // await myAdProvider.getMyAds();
                // await myPostDetailsProvider.getMyPostList();
                //  Post Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      final getAllPostScreenProvider =
                          context.read<GetAllPostScreenProvider>();

                      final myAdProvider = context.read<MyAdProvider>();

                      final myPostDetailsProvider =
                          context.read<MyPostDetailsProvider>();

                      final title = _titleController.text;
                      final description = _descriptionController.text;
                      final price = _priceController.text;
                      final tags = _tagController.text;
                      final location = _locationController.text;
                      final expireAt = _selectedExpireAt;

                      await viewModel.createPost(
                        title,
                        description,
                        price,
                        tags,
                        location,
                        expireAt,
                      );

                      if (viewModel.message != null &&
                          viewModel.message!.toLowerCase().contains(
                            'success',
                          )) {
                        await getAllPostScreenProvider.getAllPost();
                        await myAdProvider.getMyAds();
                        await myAdProvider.getMyPendingAds();
                        await myPostDetailsProvider.getMyPostList();

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Post created successfully!')),
                        );
                      } else if (viewModel.message != null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(viewModel.message!)),
                        );
                      } else {
                        _showBottomSheet(context, viewModel.subSelectedOption);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                    ),
                    child: Visibility(
                      visible: !viewModel.isLoading,
                      replacement: const Center(
                        child: CircularProgressIndicator(color: Colors.white),
                      ),
                      child: Text(
                        "Post Ad",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildTextField(
    String title,
    TextEditingController controller, {
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: AppColors.darkTextColor,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 8.h),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: TextField(
            controller: controller,
            maxLines: maxLines,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 10.h,
              ),
            ),
            style: TextStyle(fontSize: 14.sp, color: AppColors.darkTextColor),
          ),
        ),
        SizedBox(height: 24.h),
      ],
    );
  }

  Widget _buildExpireDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Expires At",
          style: TextStyle(
            color: AppColors.darkTextColor,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 8.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: DropdownButton<String>(
            value: _selectedExpireAt,
            isExpanded: true,
            icon: Icon(Icons.arrow_drop_down),
            underline: const SizedBox(),
            items: const [
              DropdownMenuItem(value: 'days_7', child: Text('7 Days')),
              DropdownMenuItem(value: 'days_14', child: Text('14 Days')),
              DropdownMenuItem(value: 'days_30', child: Text('30 Days')),
            ],
            onChanged: (v) {
              if (v == null) return;
              setState(() => _selectedExpireAt = v);
            },
          ),
        ),
        SizedBox(height: 24.h),
      ],
    );
  }

  Widget _buildCheckbox({
    required String title,
    required bool value,
    required ValueChanged<bool?> onChanged,
  }) {
    return Row(
      children: [
        SizedBox(
          width: 24.w,
          height: 24.h,
          child: Checkbox(
            value: value,
            onChanged: onChanged,
            activeColor: AppColors.primaryColor,
            side: BorderSide(color: AppColors.textFieldBox, width: 1.w),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4.r),
            ),
          ),
        ),
        SizedBox(width: 8.w),
        Text(
          title,
          style: TextStyle(color: AppColors.darkTextColor, fontSize: 16.sp),
        ),
      ],
    );
  }

  void _showBottomSheet(BuildContext context, String subSelectedOption) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder:
          (context) =>
              PostPublishedBottomSheet(listingTitle: subSelectedOption),
    );
  }
}
