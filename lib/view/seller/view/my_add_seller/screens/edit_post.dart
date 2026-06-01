import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../../cors/constant/api_end_point.dart';
import '../../../../../cors/constant/app_colors.dart';
import '../../../../../model/home/sub_category_model.dart';
import '../../../../../modelview/home/edit_post_provider.dart';
import '../../../../../modelview/home/sub_category_provider.dart';
import '../../../../../modelview/profile/my_post_details_provider.dart';
import '../../../view_model/post_viewmodel.dart';

class EditPost extends StatefulWidget {
  const EditPost({super.key});

  @override
  State<EditPost> createState() => _EditPostState();
}

class _EditPostState extends State<EditPost> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _tagController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  String type = '';
  String categoryId = '';
  List<SubCategoryModel> _categories = [];
  String parentCategoryId = '';
  String? _selectedTitle;

  @override
  void initState() {
    super.initState();
    _initializePostDetails();
  }

  Future<void> _initializePostDetails() async {
    final editPostProvider = context.read<EditPostProvider>();

    // Fetch post details
    await editPostProvider.getPostDetail();

    if (editPostProvider.postDetail != null) {
      setState(() {
        _titleController.text = editPostProvider.postDetail!.title ?? '';
        _descriptionController.text = editPostProvider.postDetail!.description ?? '';
        _priceController.text = editPostProvider.postDetail!.price ?? '';
        _tagController.text = editPostProvider.postDetail!.tags.toString();
        _locationController.text = editPostProvider.postDetail!.location ?? '';
        type = editPostProvider.postDetail!.type ?? '';
        categoryId = editPostProvider.postDetail!.categoryId ?? '';
        parentCategoryId = editPostProvider.postDetail!.category?.parentId ?? '';
        _selectedTitle = editPostProvider.postDetail!.category?.title;
      });

      // Fetch categories
      await _fetchCategories();
    }
  }

  Future<void> _fetchCategories() async {
    final subCategoryProvider = context.read<SubCategoryProvider>();
    await subCategoryProvider.getSubCategoryByParentId(parentCategoryId);

    if (mounted) {
      setState(() {
        _categories = subCategoryProvider.subCategoryList;
      });
    }
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
    final provider = context.watch<EditPostProvider>();

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
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Edit Post",
          style: TextStyle(
            color: AppColors.darkTextColor,
            fontSize: 22.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Consumer<EditPostProvider>(
          builder: (context, viewModel, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                        style: BorderStyle.solid,
                        width: 1.5.w,
                      ),
                    ),
                    child: viewModel.image != null
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
                        : ClipRRect(
                      borderRadius: BorderRadius.circular(12.r),
                      child: Image.network(
                        "${ApiEndpoints.imageBaseurl}/public/storage${provider.postDetail?.thumbnail}",
                        fit: BoxFit.cover,
                        height: 180.h,
                        width: double.infinity,
                        errorBuilder: (context, error, stackTrace) {
                          return Center(
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
                          );
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 24.h),
                _buildSectionTextField(
                  title: "Title",
                  controller: _titleController,
                ),
                _buildSectionTextField(
                  title: "Description",
                  controller: _descriptionController,
                  maxLines: 3,
                ),
                _buildSectionTextField(
                  title: "Price (optional)",
                  controller: _priceController,
                ),
                _buildSectionTextField(
                  title: "Tags (optional)",
                  controller: _tagController,
                ),
                _buildCategorySection(viewModel),
                SizedBox(height: 24.h),
                _buildSectionTextField(
                  title: "Location",
                  controller: _locationController,
                ),
                SizedBox(height: 32.h),
                _buildPostAdButton(viewModel),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildCategorySection(EditPostProvider viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
              value: _selectedTitle,
              isExpanded: true,
              borderRadius: BorderRadius.circular(12.r),
              icon: Icon(
                Icons.keyboard_arrow_down,
                size: 24.w,
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
                setState(() {
                  _selectedTitle = newValue;
                });

                viewModel.subSelectOption(newValue);

                for (SubCategoryModel category in _categories) {
                  if (category.title == newValue) {
                    viewModel.subSelectOptionId(category.id ?? '');
                    debugPrint("Selected Category ID: ${category.id}");
                  }
                }
              },
              items: _categories.map((SubCategoryModel category) {
                return DropdownMenuItem<String>(
                  value: category.title ?? '',
                  child: Text(category.title ?? ''),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPostAdButton(EditPostProvider viewModel) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () async {
          final title = _titleController.text;
          final description = _descriptionController.text;
          final price = _priceController.text;
          final tags = _tagController.text;
          final location = _locationController.text;

          final result = await viewModel.editPost(
            type,
            title,
            description,
            price,
            tags,
            categoryId,
            location,
          );
          if (result) {
            await context.read<MyPostDetailsProvider>().getMyPostList();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Post updated successfully")),
            );
            Navigator.pop(context);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Failed to update post")),
            );
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
            "Edit Post",
            style: TextStyle(
              color: AppColors.backgroundColor,
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTextField({
    required String title,
    required TextEditingController controller,
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
            keyboardType: TextInputType.multiline,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide.none,
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 8.h,
              ),
            ),
            style: TextStyle(color: AppColors.darkTextColor, fontSize: 14.sp),
          ),
        ),
        SizedBox(height: 24.h),
      ],
    );
  }
}
