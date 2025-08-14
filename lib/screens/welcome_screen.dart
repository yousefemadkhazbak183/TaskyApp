import 'package:flutter/material.dart';
import 'package:flutter_mastering_course/core/widgets/custom_svg_picture.dart';

import 'package:flutter_mastering_course/widgets/text_form_field.dart';

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
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomSvgPicture.withoutFilterColor(
                      path: 'assets/images/logo.svg',
                      width: 42,
                      height: 42,
                    ),

                    const SizedBox(width: 16),
                    Text(
                      'Tasky',
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                  ],
                ),
                const SizedBox(height: 118),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Welcome To Tasky',
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                    const SizedBox(width: 8),
                    CustomSvgPicture.withoutFilterColor(
                      path: "assets/images/wave_hand.svg",
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'Your productivity journey starts here.',
                  style: Theme.of(
                    context,
                  ).textTheme.displaySmall!.copyWith(fontSize: 16),
                ),
                const SizedBox(height: 24),
                CustomSvgPicture.withoutFilterColor(
                  path: 'assets/images/welcom.svg',
                  width: 218,
                  height: 205,
                ),

                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8),
                      Text(
                        'Full Name',
                        style: Theme.of(
                          context,
                        ).textTheme.displaySmall!.copyWith(fontSize: 16),
                      ),
                      const SizedBox(height: 8),

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
