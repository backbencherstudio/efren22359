import 'package:flutter/material.dart';
import 'package:local/cors/constant/app_images.dart';
import 'package:local/cors/routes/routes_name.dart';
import 'package:local/view/auth/login/screen/profile/profile_creation.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Import the package

class ProfileCreationScreen extends StatefulWidget {
  const ProfileCreationScreen({super.key});

  @override
  _ProfileCreationScreenState createState() => _ProfileCreationScreenState();
}

class _ProfileCreationScreenState extends State<ProfileCreationScreen> {
  String name = '';
  String email = '';
  String phone = '';
  String dob = '';
  String location = 'Austin, TX';
  bool isPhotoUploaded = true;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController locationController = TextEditingController();

  Widget buildTextField({
    required String label,
    required String hint,
    required TextEditingController controller,
    bool isReadOnly = false,
    IconButton? suffixIcon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500, color: Color(0xFFA5A5AB)), // Apply color here
        ),
        SizedBox(height: 10.h),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          readOnly: isReadOnly,
          decoration: InputDecoration(
            labelText: hint,  // Set label text
            labelStyle: TextStyle(
              color: Color(0xFFA5A5AB),  // Set label color to Color(0xFFA5A5AB)
            ),
            hintText: hint,
            hintStyle: TextStyle(color: Color(0xFF777980)),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(color: Color(0xFFDFE1E7)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(color: Color(0xFFDFE1E7)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(color: Color(0xFFDFE1E7)),
            ),
            filled: true,
            fillColor: Colors.white,
            contentPadding: EdgeInsets.symmetric(
              vertical: 16.h,
              horizontal: 16.w,
            ),
            suffixIcon: suffixIcon,
          ),
          onChanged: (value) {
            setState(() {
              if (controller == nameController) {
                name = value;
              } else if (controller == emailController) {
                email = value;
              } else if (controller == phoneController) {
                phone = value;
              } else if (controller == dobController) {
                dob = value;
              } else if (controller == locationController) {
                location = value;
              }
            });
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xFFFFFFFF),
        elevation: 0,
        title: Text(
          'Create Your Profile',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18.sp,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(
              'Skip',
              style: TextStyle(color: Color(0xFF777980), fontSize: 16.sp),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(height: 100,width: 100,
                  child: Image.asset('assets/images/profileface.png')
                ),
              ),
              SizedBox(height: 15.h),
              Center(
                child: Text(
                  'Upload Your Photo',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xff4A4C56),
                    fontSize: 14.sp,
                  ),
                ),
              ),
              SizedBox(height: 30.h),
              buildTextField(
                label: 'Name',
                hint: 'Enter your name',
                controller: nameController,
              ),
              SizedBox(height: 10.h),
              buildTextField(
                label: 'Email',
                hint: 'Enter your email',
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 10.h),
              buildTextField(
                label: 'Phone',
                hint: '+9912 345 6789',
                controller: phoneController,
                keyboardType: TextInputType.phone,
              ),
              SizedBox(height: 10.h),
              buildTextField(
                label: 'Date of Birth',
                hint: '16 Aug,1998',
                controller: dobController,
                isReadOnly: true,
                suffixIcon: IconButton(
                  icon: Image.asset('assets/images/Icon.png', width: 20.w,height: 21.h,),
                  onPressed: () {
                    setState(() {
                      dob = '16 Aug 1998';
                    });
                  },
                ),
              ),
              SizedBox(height: 20.h),
              buildTextField(
                label: 'Location',
                hint: 'Austin,TX',
                suffixIcon: IconButton(
                  icon: Image.asset('assets/images/location.png', width: 24.w),
                  onPressed: () {},
                ),
                controller: locationController,
              ),
              SizedBox(height: 40.h),
              SizedBox(
                width: double.infinity,
                height: 55.h, // Adjusted for scaling
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, RouteName.profileCreation);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xff5D18EB),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    'Next',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
