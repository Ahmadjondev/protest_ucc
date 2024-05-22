import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:protest/common/app_colors.dart';
import 'package:protest/common/app_text_styles.dart';
import 'package:protest/common/constants.dart';
import 'package:protest/features/widgets/gradient_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../common/routes.dart';

class OnboardScreen extends StatefulWidget {
  const OnboardScreen({super.key});

  @override
  State<OnboardScreen> createState() => _OnboardScreenState();
}

class _OnboardScreenState extends State<OnboardScreen> {
  PageController controller = PageController();

  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Flexible(
              child: PageView.builder(
                controller: controller,
                itemCount: onboardingData.length,
                itemBuilder: (_, index) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      SizedBox(
                        height: size.height * .12,
                      ),
                      SvgPicture.asset(onboardingData[index].icon),
                      SizedBox(height: 30),
                      SizedBox(
                        width: size.width,
                        child: Text(
                          onboardingData[index].text,
                          textAlign: TextAlign.center,
                          style: AppTextStyles.body24w7.copyWith(
                            color: AppColors.primaryColor,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SmoothPageIndicator(
              controller: controller,
              count: onboardingData.length,
              effect: ExpandingDotsEffect(
                dotHeight: 8,
                dotWidth: 8,
                dotColor: AppColors.grey,
                activeDotColor: AppColors.primaryColor,
              ),
              onDotClicked: (newIndex) {
                setState(() {
                  currentIndex = newIndex;
                  controller.animateToPage(newIndex,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.ease);
                });
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: bottomNextButton(),
    );
  }

  Widget bottomNextButton() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20, top: 60, left: 20, right: 20),
      child: GradientButton(
        onPressed: () async {
          if ((controller.page?.toInt() ?? 0) < onboardingData.length - 2) {
            controller.nextPage(
                duration: const Duration(milliseconds: 350),
                curve: Curves.fastOutSlowIn);
            print(controller.page);
          } else {
            SharedPreferences pref = await SharedPreferences.getInstance();
            pref.setBool(SharedConstants.oboard, true);
            context.go(Routes.home);
            // context.go(Routes.login);
          }
        },
        height: 58,
        text: "Davom etish",
        radius: 100,
      ),
    );
  }
}
