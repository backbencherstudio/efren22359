import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:local/view/seller/view/message/modal_view/chat_response_provider.dart';
import 'package:provider/provider.dart';

class ResponseMessageAppBar extends StatelessWidget {
  const ResponseMessageAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(onTap: () => Navigator.pop(context), child: Icon(Icons.arrow_back_ios_new)),
            Expanded(
              child: ListTile(
                title: Text('Conversations', style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600),),
                subtitle: Text(Provider.of<ChatResponseProvider>(context).selectedResponse!),
              ),
            )
          ],
        ),
        SizedBox(height: 10.h),
        Divider(),
      ],
    );
  }
}
