import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:protest/common/app_colors.dart';
import 'package:protest/common/app_text_styles.dart';
import 'package:protest/common/assets.dart';
import 'package:protest/common/routes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 80,
        forceMaterialTransparency: true,
        leading: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Image.asset(
            Assets.avatarsAvatar1,
            height: 40,
            width: 40,
          ),
        ),
        title: const Text(
          "Ahmadjon Abduhoshimjonov",
          style: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(Assets.iconsNotification),
          )
        ],
      ),
      body: Column(
        children: [
          Stack(
            children: [
              SvgPicture.asset(
                Assets.iconsBackDtm,
                width: size.width,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "UZBMB Test yechish",
                      style:
                          AppTextStyles.body22w7.copyWith(color: Colors.white),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "UZBMB Testini yechish orqali qaysi mavzularni chuqurroq o'rganish kerakligini o’rganib oling",
                      style: AppTextStyles.body14w5
                          .copyWith(color: Colors.white.withOpacity(.6)),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        context.push(Routes.uzbmb);
                      },
                      child: Text(
                        "Boshlash",
                        style: AppTextStyles.body14w5.copyWith(
                          color: Colors.white,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                          elevation: 0,
                          // tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          fixedSize: Size(size.width, 45),
                          backgroundColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                              side: BorderSide(color: Colors.white, width: 1))),
                    )
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Oxirgi Natijalar', style: AppTextStyles.body20w7),
                Text('Barchasi',
                    style: AppTextStyles.body16w7
                        .copyWith(color: AppColors.primaryColor))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
