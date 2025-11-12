import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/common_widgets/custom_button.dart';
import 'package:movies_app/core/config/app_colors.dart';
import 'package:movies_app/features/onboarding/data/model/onBoarding_model.dart';
import 'package:movies_app/features/onboarding/presentation/onboarding_cubit/onboarding_cubit.dart';
import 'package:movies_app/features/onboarding/widget/pages.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OnboardingCubit(),
      child: Scaffold(
        body: BlocBuilder<OnboardingCubit, int>(
          builder: (context, page) {
            var cubit = context.read<OnboardingCubit>();
            int totalPage = OnboardingModel.onboardingList.length;
            bool isLastPage = page == OnboardingModel.onboardingList.length - 1;
            bool isFirstPage = page == 0;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: PageView.builder(
                    itemCount: totalPage,
                    onPageChanged: cubit.onPageChanged,
                    controller: cubit.pageController,
                    itemBuilder: (context, index) {
                      return Pages(
                        model: OnboardingModel.onboardingList[index],
                      );
                    },
                  ),
                ),
                CustomButton(
                  onTap: () {
                    cubit.nextPage(context);
                    
                  },
                  content: isLastPage ? "Get Started" : "Next",
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 16,
                  ),
                  child: isFirstPage
                      ? null
                      : OutlinedButton(
                          onPressed: () {
                            cubit.previousPage(context);
                          },
                          style: OutlinedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            side: BorderSide(
                              color: AppColors.primary,
                              width: 2,
                            ),
                          ),
                          child: Text(
                            "back",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                ),
                SizedBox(height: 10),
              ],
            );
          },
        ),
      ),
    );
  }
}
