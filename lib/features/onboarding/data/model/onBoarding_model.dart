import 'package:movies_app/core/config/app_images.dart';

class OnboardingModel {
  final String image;
  final String title;
  final String description;

  OnboardingModel({
    required this.image,
    required this.title,
    required this.description,
  });
  static List<OnboardingModel> onboardingList = [
    OnboardingModel(
      image: AppImages.intro1,
      title: "Discover Movies",
      description:
          "Explore a vast collection of movies in all qualities and genres. Find your next favorite film with ease.",
    ),
    OnboardingModel(
      image: AppImages.intro2,
      title: "Explore All Genres",
      description:
          "Discover movies from every genre, in all available qualities. Find something new and exciting to watch every day.",
    ),
    OnboardingModel(
      image: AppImages.intro3,
      title: "Create Watch lists",
      description:
          "Save movies to your watch list to keep track of what you want to watch next. Enjoy films in various qualities and genres.",
    ),
    OnboardingModel(
      image: AppImages.intro4,
      title: "Rate, Review, and Learn",
      description:
          "Share your thoughts on the movies you've watched. Dive deep into film details and help others discover great movies with your reviews.",
    ),
    OnboardingModel(
      image: AppImages.intro5,
      title: "Start Watching Now",
      description: "",
    ),
  ];
}
