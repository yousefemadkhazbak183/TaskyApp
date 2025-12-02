import 'package:flutter/material.dart';
import 'package:flutter_mastering_course/core/constants/app_sizes.dart';
import 'package:flutter_mastering_course/core/widgets/custom_svg_picture.dart';

import 'package:flutter_mastering_course/core/components/text_form_field.dart';

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
                SizedBox(height: AppSizes.ph16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomSvgPicture.withoutFilterColor(
                      path: 'assets/images/logo.svg',
                      width: AppSizes.w42,
                      height: AppSizes.h42,
                    ),

                    SizedBox(width: AppSizes.w16),
                    Text(
                      'Tasky',
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                  ],
                ),
                SizedBox(height: AppSizes.ph118),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Welcome To Tasky',
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                    SizedBox(width: AppSizes.pw8),
                    CustomSvgPicture.withoutFilterColor(
                      path: "assets/images/wave_hand.svg",
                    ),
                  ],
                ),
                SizedBox(height: AppSizes.ph8),
                Text(
                  'Your productivity journey starts here.',
                  style: Theme.of(
                    context,
                  ).textTheme.displaySmall!.copyWith(fontSize: AppSizes.sp16),
                ),
                SizedBox(height: AppSizes.ph24),
                CustomSvgPicture.withoutFilterColor(
                  path: 'assets/images/welcom.svg',
                  width: AppSizes.w200,
                  height: AppSizes.h200,
                ),

                SizedBox(height: AppSizes.ph24),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppSizes.w16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: AppSizes.ph8),
                      Text(
                        'Full Name',
                        style: Theme.of(
                          context,
                        ).textTheme.displaySmall!.copyWith(fontSize: 16),
                      ),
                      SizedBox(height: AppSizes.ph8),

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
