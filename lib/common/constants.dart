import 'package:protest/common/assets.dart';
import 'package:protest/common/models/bottom_navigation_model.dart';

import 'models/onboard_model.dart';

List<OnboardingModel> onboardingData = [
  OnboardingModel(
      icon: Assets.iconsOnboard1,
      text: "Biz eng yaxshi o'quv kurslarni taqdim etamiz!"),
  OnboardingModel(
      icon: Assets.iconsOnboard2,
      text: "Istalgan vaqtda, istalgan joyda oson va qulay o'rganing"),
  OnboardingModel(
      icon: Assets.iconsOnboard3,
      text: "Keling, hoziroq ProTest bilan bilimingizni oshirishni boshlaymiz"),
];

List<BottomNavigationModel> bottomNavigations = [
  BottomNavigationModel(
    icon: Assets.iconsHome,
    activeIcon: Assets.iconsHomeActive,
    name: "Bosh sahifa",
  ),
  BottomNavigationModel(
    icon: Assets.iconsRating,
    activeIcon: Assets.iconsRatingActive,
    name: "Yetakchilar",
  ),
  BottomNavigationModel(
    icon: Assets.iconsCompetition,
    activeIcon: Assets.iconsCompetitionActive,
    name: "Kutubxona",
  ),
  BottomNavigationModel(
    icon: Assets.iconsProfile,
    activeIcon: Assets.iconsProfileActive,
    name: "Hisob",
  ),
];

class SharedConstants {
  SharedConstants._();

  static const String oboard = 'onboard';
  static const String token = 'token';
}
