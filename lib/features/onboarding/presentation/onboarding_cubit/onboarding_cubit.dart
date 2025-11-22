import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/config/app_routes.dart';
import 'package:movies_app/features/onboarding/data/model/onBoarding_model.dart';

class OnboardingCubit extends Cubit<int> {
  OnboardingCubit() : super(0);

  final PageController pageController = PageController();

  void onPageChanged(int index) {
    emit(index);
  }

  void nextPage(BuildContext context) {
    int totalPage = OnboardingModel.onboardingList.length;

    if (state < totalPage - 1) {
      pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    } else {
      Navigator.pushReplacementNamed(context, AppRoutes.loginScreen);
    }
  }

  void previousPage(BuildContext context) {
    pageController.previousPage(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
  }

  Future<void> dispose() async {
    pageController.dispose();
    return super.close();
  }
}
