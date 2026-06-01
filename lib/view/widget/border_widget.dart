import 'package:flutter/material.dart';

class BorderWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, // To make it full width
      height: 1.0, // Thin border height
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.withOpacity(0.3), // Light gray color
            width: 1.0, // Thin line width
          ),
        ),
      ),
    );
  }
}
