import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:protest/common/assets.dart';
import 'package:protest/common/constants.dart';
import 'package:protest/common/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> loadingAnim;

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    loadingAnim =
        Tween<double>(begin: 0, end: pi * 2).animate(animationController);
    animationController.forward();
    animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animationController.reset();
        animationController.forward();
      }
    });

    Timer(
      Duration(seconds: 3),
      () async {
        SharedPreferences pref = await SharedPreferences.getInstance();
        bool? onboard = pref.getBool(SharedConstants.oboard);
        if (onboard != null) {
          context.go(Routes.home);
        } else {
          context.go(Routes.onboard);
        }
      },
    );
  }

  @override
  void dispose() {
    if (animationController.isAnimating) {
      animationController.stop();
    }
    animationController.dispose();
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: Center(child: SvgPicture.asset(Assets.iconsTitle)),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 60,
            child: AnimatedBuilder(
              animation: loadingAnim,
              builder: (context, child) {
                return Transform.rotate(
                  angle: loadingAnim.value,
                  child: SvgPicture.asset(Assets.iconsLoading),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
