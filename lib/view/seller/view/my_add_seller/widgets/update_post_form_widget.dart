import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../cors/constant/app_colors.dart';
import '../bottom_sheet/post_updated_bottom_sheet.dart';

class UpdatePostFormWidget extends StatefulWidget {
  const UpdatePostFormWidget({Key? key}) : super(key: key);

  @override
  State<UpdatePostFormWidget> createState() => _UpdatePostFormWidgetState();
}

class _UpdatePostFormWidgetState extends State<UpdatePostFormWidget> {
  // Text controllers for form fields
  final TextEditingController _titleController = TextEditingController(text: "At-Home Facial Treatment");
  final TextEditingController _descriptionController = TextEditingController(
      text: "Enjoy a relaxing facial from the comfort of your own home. This 60-minute treatment includes:\n"
          "• Deep cleansing\n"
          "• Exfoliation\n"
          "• Hydrating mask\n"
          "• Steam therapy\n"
          "• Light facial massage\n"
          "• Skin-type-specific moisturizing\n"
          "Perfect for all skin types. Products used are organic and dermatologically tested."
  );
  final TextEditingController _priceController = TextEditingController(text: "45");
  final TextEditingController _tagController = TextEditingController(); // No initial text for tags
  final TextEditingController _locationController = TextEditingController(text: "Austin, TX");

  String? _selectedCategory = 'Service'; // Initial value for dropdown

  // List of categories for the dropdown
  final List<String> _categories = ['Service', 'Product', 'Job', 'Other'];

  // State variables for image handling
  String? _currentDisplayedImagePath; // Holds the path (network URL or local file path) of the displayed image
  bool _showImagePlaceholder = false; // Controls visibility of the '+' button placeholder

  @override
  void initState() {
    super.initState();
    // Initialize with the dummy network image
    _currentDisplayedImagePath = 'https://picsum.photos/seed/facial_treatment/800/600';
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

  /// Handles picking an image from the gallery.
  /// Uses the `image_picker` package to select an image.
  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _currentDisplayedImagePath = image.path; // Update to local file path
        _showImagePlaceholder = false; // Hide placeholder, show image
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.w), // Overall padding for the form.
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Align content to the left.
        children: [
          // Image display area with conditional rendering for image or placeholder
          Stack(
            children: [
              // Conditional display: If placeholder is shown or no image path, show placeholder.
              // Otherwise, display the image (network or file).
              _showImagePlaceholder || _currentDisplayedImagePath == null
                  ? Container(
                width: double.infinity,
                height: 200.h,
                decoration: BoxDecoration(
                  color: AppColors.fieldColor, // Light background for placeholder
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Center(
                  child: GestureDetector(
                    onTap: _pickImage, // Tap the placeholder to pick an image
                    child: Container(
                      padding: EdgeInsets.all(20.w),
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.add_a_photo, // '+' icon for adding photo
                        size: 40.w,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                ),
              )
                  : ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: _currentDisplayedImagePath!.startsWith('http')
                    ? Image.network(
                  _currentDisplayedImagePath!,
                  width: double.infinity,
                  height: 200.h,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    // Fallback for network image loading errors
                    return Container(
                      width: double.infinity,
                      height: 200.h,
                      color: AppColors.fieldColor,
                      child: Center(
                        child: Icon(
                          Icons.broken_image,
                          size: 50.w,
                          color: AppColors.lightTextColor,
                        ),
                      ),
                    );
                  },
                )
                    : Image.file( // Display image from local file path
                  File(_currentDisplayedImagePath!),
                  width: double.infinity,
                  height: 200.h,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    // Fallback for local file image loading errors
                    return Container(
                      width: double.infinity,
                      height: 200.h,
                      color: AppColors.fieldColor,
                      child: Center(
                        child: Icon(
                          Icons.broken_image,
                          size: 50.w,
                          color: AppColors.lightTextColor,
                        ),
                      ),
                    );
                  },
                ),
              ),
              // Close button (only visible if an image is currently displayed)
              if (!_showImagePlaceholder && _currentDisplayedImagePath != null)
                Positioned(
                  top: 8.h,
                  right: 8.w,
                  child: GestureDetector(
                    onTap: () {
                      // On tap, clear the image and show the placeholder
                      setState(() {
                        _currentDisplayedImagePath = null;
                        _showImagePlaceholder = true;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.all(4.w),
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.close,
                        color: AppColors.backgroundColor,
                        size: 20.w,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: 24.h), // Spacing below the image.

          // Title Section
          Text(
            "Tittle", // Typo in screenshot, keeping as is.
            style: TextStyle(
              color: AppColors.darkTextColor,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8.h),
          TextField(
            controller: _titleController,
            decoration: InputDecoration(
              filled: true,
              fillColor: AppColors.fieldColor,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide.none,
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            ),
            style: TextStyle(
              color: AppColors.darkTextColor,
              fontSize: 16.sp,
            ),
          ),
          SizedBox(height: 24.h),

          // Description Section
          Text(
            "Description",
            style: TextStyle(
              color: AppColors.darkTextColor,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8.h),
          TextField(
            controller: _descriptionController,
            maxLines: null, // Allows for multiple lines
            minLines: 5, // Minimum 5 lines visible
            keyboardType: TextInputType.multiline,
            decoration: InputDecoration(
              filled: true,
              fillColor: AppColors.fieldColor,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide.none,
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            ),
            style: TextStyle(
              color: AppColors.darkTextColor,
              fontSize: 16.sp,
            ),
          ),
          SizedBox(height: 24.h),

          // Price Section
          Text(
            "Price",
            style: TextStyle(
              color: AppColors.darkTextColor,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8.h),
          TextField(
            controller: _priceController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              filled: true,
              fillColor: AppColors.fieldColor,
              prefixText: '\$', // Dollar sign prefix
              prefixStyle: TextStyle(
                color: AppColors.darkTextColor,
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide.none,
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            ),
            style: TextStyle(
              color: AppColors.darkTextColor,
              fontSize: 16.sp,
            ),
          ),
          SizedBox(height: 24.h),

          // Tag Section
          Text(
            "Tag",
            style: TextStyle(
              color: AppColors.darkTextColor,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8.h),
          TextField(
            controller: _tagController,
            decoration: InputDecoration(
              filled: true,
              fillColor: AppColors.fieldColor,
              hintText: "Add tags (e.g., facial, beauty, home-service)", // Placeholder text
              hintStyle: TextStyle(
                color: AppColors.lightTextColor,
                fontSize: 16.sp,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide.none,
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            ),
            style: TextStyle(
              color: AppColors.darkTextColor,
              fontSize: 16.sp,
            ),
          ),
          SizedBox(height: 24.h),

          // Category Section
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
              color: AppColors.fieldColor,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _selectedCategory,
                isExpanded: true,
                icon: Icon(Icons.keyboard_arrow_down, size: 24.w, color: AppColors.darkTextColor),
                style: TextStyle(
                  color: AppColors.darkTextColor,
                  fontSize: 16.sp,
                ),
                dropdownColor: AppColors.fieldColor, // Background color of the dropdown menu
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedCategory = newValue;
                  });
                },
                items: _categories.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
          ),
          SizedBox(height: 24.h),

          // Location Section
          Text(
            "Location:",
            style: TextStyle(
              color: AppColors.darkTextColor,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8.h),
          TextField(
            controller: _locationController,
            decoration: InputDecoration(
              filled: true,
              fillColor: AppColors.fieldColor,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide.none,
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            ),
            style: TextStyle(
              color: AppColors.darkTextColor,
              fontSize: 16.sp,
            ),
          ),
          SizedBox(height: 32.h), // Spacing before the button.

          // Update Post Button
          SizedBox(
            width: double.infinity, // Button takes full width.
            child: ElevatedButton(
              onPressed: () {

                _showBottomSheet(context);


                // Handle update post logic here
                debugPrint("Title: ${_titleController.text}");
                debugPrint("Description: ${_descriptionController.text}");
                debugPrint("Price: ${_priceController.text}");
                debugPrint("Tags: ${_tagController.text}");
                debugPrint("Category: $_selectedCategory");
                debugPrint("Location: ${_locationController.text}");
                debugPrint("Image Path: $_currentDisplayedImagePath");
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor, // Use primary color for button.
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r), // Rounded button corners.
                ),
                padding: EdgeInsets.symmetric(vertical: 16.h), // Vertical padding for button.
              ),
              child: Text(
                "Update Post",
                style: TextStyle(
                  color: AppColors.backgroundColor, // White text for the button.
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Allow the bottom sheet to be scrollable
      backgroundColor: Colors.transparent, // Make background transparent to show the sheet with custom style
      builder: (BuildContext context) {
        return PostUpdatedBottomSheet(); // Your custom bottom sheet widget
      },
    );
  }
}
