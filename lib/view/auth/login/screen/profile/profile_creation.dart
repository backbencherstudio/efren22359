import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:local/cors/routes/routes_name.dart';
import 'package:local/view/seller/view/seller_parent/screen/seller_parent_screen.dart';
import 'package:provider/provider.dart';

class ProfileCreationProvider with ChangeNotifier {
  final List<String> experienceList = [
    'Photoshop',
    'Figma',
    'Illustrator',
    'Canva',
    'UI/UX Design',
    'Blender'
  ];
  List<String> selectedExperience = [];
  TextEditingController descriptionController = TextEditingController();
  void toggleExperience(String experience) {
    if (selectedExperience.contains(experience)) {
      selectedExperience.remove(experience);
    } else {
      selectedExperience.add(experience);
    }
    notifyListeners();
  }

  void updateDescription(String description) {
    descriptionController.text = description;
    notifyListeners();
  }

  void removeExperience(String experience) {
    selectedExperience.remove(experience);
    notifyListeners();
  }
}

class ProfileCreation extends StatelessWidget {
  const ProfileCreation({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProfileCreationProvider(),
      child: const ProfileCreationPage(),
    );
  }
}

class ProfileCreationPage extends StatelessWidget {
  const ProfileCreationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProfileCreationProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Color(0xff777980)),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text(
          'Create Your Profile',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text(
              'Skip',
              style: TextStyle(fontSize: 16,color: Color(0xFF777980)),
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
              SizedBox(height: 30.h),
              const Text(
                'Experience',
                style: TextStyle(
                    color:  Color(0xFF777980),
                    fontSize: 16),
              ),
              SizedBox(height: 10.h),
              Container(
                padding: EdgeInsets.all(16.w),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      spacing: 10.w,
                      runSpacing: 10.h,
                      children: provider.experienceList.map((experience) {
                        return Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 15.w, vertical: 6.h),
                          decoration: BoxDecoration(
                            color: provider.selectedExperience.contains(experience)
                                ? Color(0xFFF6F8FA)
                                : Color(0xFFF6F8FA),
                            borderRadius: BorderRadius.circular(20.r),
                            border: Border.all(
                              color: provider.selectedExperience.contains(experience)
                                  ? Color(0xFFDFE1E7)
                                  : Color(0xFFDFE1E7),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              GestureDetector(
                                onTap: () => provider.toggleExperience(experience),
                                child: Text(
                                  experience,
                                  style: TextStyle(
                                    color: provider.selectedExperience.contains(experience)
                                        ? Colors.black
                                        : Colors.black,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              SizedBox(width: 8.w),
                              GestureDetector(
                                onTap: () => provider.removeExperience(experience),
                                child: Icon(
                                  Icons.close,
                                  color: Colors.black,
                                  size: 18.w,
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 20.h),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF4A4C56),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        'Add +',
                        style: TextStyle(fontSize: 16,color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30.h),
              const Text(
                'Experience',
                style: TextStyle(
                    color: Color(0xFF777980),
                    fontSize: 16),
              ),
              SizedBox(height: 15.h),
              TextField(
                controller: provider.descriptionController,
                maxLines: 7,
                decoration: InputDecoration(
                  hintText:
                  'I am a graphic designer based in Austin, TX, specializing in logo creation and branding. I love creating innovative designs that truly represent a business’s identity.',
                  hintStyle: TextStyle(color: Color(0xFFA5A5AB)),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide(color: Color(0xFFD2D2D5)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide(color: Color(0xFFD2D2D5)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide(color: Color(0xFFD2D2D5)),
                  ),
                  contentPadding: EdgeInsets.all(16.w),
                ),
                onChanged: (value) {
                  provider.updateDescription(value);
                },
              ),
              SizedBox(height: 60.h),
              SizedBox(
                width: double.infinity,
                height: 55.h,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, RouteName.sellerParentScreen);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff5D18EB),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Complete',
                    style: TextStyle(
                      fontSize: 18,
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