import 'package:flutter/material.dart';
import 'package:flutter_mastering_course/core/widgets/custom_svg_picture.dart';

import 'package:flutter_mastering_course/core/components/text_form_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WelcomeScreen extends StatelessWidget {
  WelcomeScreen({super.key});

  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 16.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomSvgPicture.withoutFilterColor(
                      path: 'assets/images/logo.svg',
                      width: 42.w,
                      height: 42.h,
                    ),

                    SizedBox(width: 16.w),
                    Text(
                      'Tasky',
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                  ],
                ),
                SizedBox(height: 118.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Welcome To Tasky',
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                    SizedBox(width: 8.w),
                    CustomSvgPicture.withoutFilterColor(
                      path: "assets/images/wave_hand.svg",
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                Text(
                  'Your productivity journey starts here.',
                  style: Theme.of(
                    context,
                  ).textTheme.displaySmall!.copyWith(fontSize: 16.sp),
                ),
                SizedBox(height: 24.h),
                CustomSvgPicture.withoutFilterColor(
                  path: 'assets/images/welcom.svg',
                  width: 218.w,
                  height: 205.h,
                ),

                SizedBox(height: 24.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 8.h),
                      Text(
                        'Full Name',
                        style: Theme.of(
                          context,
                        ).textTheme.displaySmall!.copyWith(fontSize: 16),
                      ),
                      SizedBox(height: 8.h),

                      TextFormFieldWidget(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
