import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:local/modelview/auth/login_provider/login_screen_provider.dart';
import 'package:local/view/seller/view_model/seller_parent_screen_provider.dart';
import 'package:local/view/widget/custom_text_field.dart';
import 'package:provider/provider.dart';

import '../../../cors/constant/api_end_point.dart';
import '../../../cors/constant/app_colors.dart';
import '../../../cors/routes/routes_name.dart';
import '../../../modelview/profile/edit_profile_provider.dart';

class GeneralSettingsScreen extends StatefulWidget {
  const GeneralSettingsScreen({Key? key}) : super(key: key);

  @override
  State<GeneralSettingsScreen> createState() => _GeneralSettingsScreenState();
}

class _GeneralSettingsScreenState extends State<GeneralSettingsScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _dateOfBirthController = TextEditingController();
  final TextEditingController _aboutController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _zipCodeController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _skillsController = TextEditingController();

  List<String> selectedSkills = [];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await context.read<LoginScreenProvider>().getMe();
      _nameController.text = context.read<LoginScreenProvider>().user?.name ?? '';
      _phoneNumberController.text = context.read<LoginScreenProvider>().user?.phoneNumber ?? '';
      _genderController.text = context.read<LoginScreenProvider>().user?.gender ?? '';
      _aboutController.text = context.read<LoginScreenProvider>().user?.about ?? '';
      _addressController.text = context.read<LoginScreenProvider>().user?.address ?? '';
      _dateOfBirthController.text = DateFormat('dd MMM yyyy').format(DateTime.parse(context.read<LoginScreenProvider>().user?.dateOfBirth.toString() ?? ''));
    });
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _locationController.dispose();
    _phoneNumberController.dispose();
    _dateOfBirthController.dispose();
    _aboutController.dispose();
    _genderController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _countryController.dispose();
    _stateController.dispose();
    _cityController.dispose();
    _zipCodeController.dispose();
    _addressController.dispose();
    _skillsController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(1998, 8, 16),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.primaryColor,
              onPrimary: AppColors.backgroundColor,
              onSurface: AppColors.darkTextColor,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: AppColors.primaryColor,
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      final String formattedDate =
          "${picked.day} ${['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'][picked.month - 1]} ${picked.year}";
      setState(() {
        _dateOfBirthController.text = formattedDate;
      });
    }
  }

  // Function to handle adding skills
  void _addSkill(String skill) {
    if (skill.isNotEmpty && !selectedSkills.contains(skill)) {
      setState(() {
        selectedSkills.add(skill);
      });
      _skillsController.clear();
    }
  }

  // Function to handle removing skills
  void _removeSkill(String skill) {
    setState(() {
      selectedSkills.remove(skill);
    });
  }

  @override
  Widget build(BuildContext context) {
    final loginProvider = context.watch<LoginScreenProvider>();
    final editProfileProvider = context.read<EditProfileProvider>();
    final profileProvider = context.watch<EditProfileProvider>();

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
          "General Settings",
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Stack(
                children: [
                  GestureDetector(
                    onTap: () => editProfileProvider.pickImage(),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(90.r),
                      child: Container(
                        height: 100.w,
                        width: 100.w,
                        decoration: BoxDecoration(
                          color: AppColors.fieldColor,
                          shape: BoxShape.circle,
                        ),
                        child:
                        profileProvider.image != null
                            ? Image.file(profileProvider.image!)
                            : Image.network(
                          '${ApiEndpoints.imageBaseurl}/public/storage/avatar/${loginProvider.user?.avatar}',
                          height: 100.w,
                          width: 100.w,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(
                              Icons.broken_image_outlined,
                              size: 40,
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: EdgeInsets.all(4.w),
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.edit, color: Colors.white, size: 16.w),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 12.h),
            _buildFields(
              title: "Name",
              controller: _nameController,
              hintText: "Enter your name",
            ),
            _buildFields(
              title: "Phone Number",
              controller: _phoneNumberController,
              hintText: "Enter your phone number",
            ),
            _buildFields(
              title: "Gender",
              controller: _genderController,
              hintText: "Enter your gender",
            ),
            Text(
              "Date Of Birth",
              style: TextStyle(
                color: AppColors.darkTextColor,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 8.h),
            TextField(
              controller: _dateOfBirthController,
              readOnly: true,
              onTap: () => _selectDate(context),
              decoration: InputDecoration(
                suffixIcon: Icon(
                  Icons.calendar_month_outlined,
                  color: AppColors.lightTextColor,
                  size: 20.w,
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 12.h,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: BorderSide(
                    color: Colors.grey.shade300,
                    width: 1.w,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: BorderSide(
                    color: AppColors.primaryColor,
                    width: 2.w,
                  ),
                ),
              ),
              style: TextStyle(color: AppColors.darkTextColor, fontSize: 16.sp),
            ),
            SizedBox(height: 16.h),
            _buildFields(
              title: "About",
              controller: _aboutController,
              hintText: "Enter your bio",
            ),
            _buildFields(
              title: "First Name*",
              controller: _firstNameController,
              hintText: "Enter your first name",
            ),
            _buildFields(
              title: "Last Name*",
              controller: _lastNameController,
              hintText: "Enter your last name",
            ),
            _buildFields(
              title: "Address",
              controller: _addressController,
              hintText: "Enter your address",
            ),
            SizedBox(height: 16.h),
            // Skill selection field
            Text(
              "Skills",
              style: TextStyle(
                color: AppColors.darkTextColor,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 8.h),
            TextField(
              controller: _skillsController,
              decoration: InputDecoration(
                hintText: "Enter skills",
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 12.h,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: BorderSide(
                    color: Colors.grey.shade300,
                    width: 1.w,
                  ),
                ),
              ),
              onSubmitted: (value) {
                _addSkill(value);
              },
            ),
            SizedBox(height: 8.h),
            Wrap(
              spacing: 8.0.w,
              runSpacing: 4.0.h,
              children: selectedSkills
                  .map((skill) => Chip(
                label: Text(skill),
                onDeleted: () => _removeSkill(skill),
              ))
                  .toList(),
            ),
            SizedBox(height: 40.h),
            SizedBox(
              width: double.infinity,
              child: Consumer<EditProfileProvider>(
                  builder: (_, pr, __) {
                    return Visibility(
                      visible: !pr.isLoading,
                      replacement: const Center(
                        child: CircularProgressIndicator(),
                      ),
                      child: ElevatedButton(
                        onPressed: () async {
                          bool res = false;
                          if (_firstNameController.text.isEmpty ||
                              _lastNameController.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    "First name and last name are required"),
                                duration: const Duration(seconds: 2),
                              ),
                            );
                          } else {
                            res = await pr.updateProfile(
                              _nameController.text,
                              _phoneNumberController.text,
                              _genderController.text,
                              _dateOfBirthController.text,
                              _aboutController.text,
                              _firstNameController.text,
                              _lastNameController.text,
                              _addressController.text,
                              selectedSkills,
                            );
                          }
                          if (mounted) {
                            if (res) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("Profile updated successfully"),
                                  duration: const Duration(seconds: 2),
                                ),
                              );
                              await context.read<LoginScreenProvider>().getMe();
                              Navigator.pushReplacementNamed(context, RouteName.sellerParentScreen);
                              context.read<SellerParentScreenProvider>().onSelectedIndex(4);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("Profile update failed"),
                                  duration: const Duration(seconds: 2),
                                ),
                              );
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 16.h),
                        ),
                        child: Text(
                          "Save Changes",
                          style: TextStyle(
                            color: AppColors.backgroundColor,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    );
                  }
              ),
            ),
            SizedBox(height: 12.h),
          ],
        ),
      ),
    );
  }

  Column _buildFields({
    required String title,
    required TextEditingController controller,
    required String hintText,
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
        CustomTextField(
          controller: controller,
          hintText: hintText,
        ),
        SizedBox(height: 16.h),
      ],
    );
  }
}
