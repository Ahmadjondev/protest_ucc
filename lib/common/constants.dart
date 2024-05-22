import 'package:protest/common/assets.dart';

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

class SharedConstants {
  SharedConstants._();

  static final String oboard = 'onboard';
  static final String token = 'token';
}
