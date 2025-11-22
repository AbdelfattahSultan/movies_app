import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies_app/core/config/app_colors.dart';
import 'package:movies_app/core/config/app_images.dart';
import 'package:movies_app/core/config/app_routes.dart';
import 'package:movies_app/features/home_screen/tabs/profile_tab/data/models/user_model.dart';
import 'package:movies_app/features/home_screen/tabs/profile_tab/presentation/cubit/profile_cubit/profile_cubit.dart';
import 'package:movies_app/features/home_screen/tabs/profile_tab/presentation/cubit/profile_cubit/profile_state.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  bool showAvatars = false;
  int selectedAvatar = 0;
  late UserModel user;
  late TextEditingController nameController;
  late TextEditingController phoneController;

  final List<String> avatars = [
    AppImages.avatar1,
    AppImages.avatar2,
    AppImages.avatar3,
    AppImages.avatar4,
    AppImages.avatar5,
    AppImages.avatar6,
    AppImages.avatar7,
    AppImages.avatar8,
    AppImages.avatar9,
  ];

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    phoneController = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    user = ModalRoute.of(context)!.settings.arguments as UserModel;
    selectedAvatar = (user.avaterId <= 0 ? 0 : user.avaterId - 1);
    nameController.text = user.name;
    phoneController.text = user.phone;
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<ProfileCubit>(context),
      child: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state is ProfileUpdated) {
            Future.delayed(const Duration(milliseconds: 300), () {
              context.read<ProfileCubit>().getProfile();
              Navigator.pop(context);
            });
          } else if (state is ProfileDeleted) {
            Future.delayed(const Duration(milliseconds: 300), () {
              Navigator.pushReplacementNamed(context, AppRoutes.loginScreen);
            });
          }
        },
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const Scaffold(
              backgroundColor: AppColors.eerieBlack,
              body: Center(
                child: CircularProgressIndicator(color: Colors.yellow),
              ),
            );
          }

          return Scaffold(
            backgroundColor: AppColors.eerieBlack,
            appBar: AppBar(
              backgroundColor: AppColors.eerieBlack,
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: AppColors.primary,
                  size: 30,
                ),
                onPressed: () => Navigator.pop(context),
              ),
              title: TextButton(
                onPressed: () {
                  setState(() {
                    showAvatars = !showAvatars;
                  });
                },
                child: Text(
                  "Pick Avatar",
                  style: TextStyle(color: AppColors.primary, fontSize: 18),
                ),
              ),
              centerTitle: true,
            ),
            body: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(height: 40),
                      Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.asset(
                            avatars[selectedAvatar],
                            height: 150,
                            width: 150,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(height: 35),
                      _buildTextField(
                        context,
                        controller: nameController,
                        icon: AppImages.userIcon,
                        hint: "Enter your name",
                      ),
                      const SizedBox(height: 20),
                      _buildTextField(
                        context,
                        controller: phoneController,
                        icon: AppImages.phoneIcon,
                        hint: "Enter phone number",
                        keyboardType: TextInputType.phone,
                      ),
                      const SizedBox(height: 25),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: TextButton(
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              AppRoutes.resetPasswordScreen,
                            );
                          },
                          child: Text(
                            "Reset Password",
                            style: GoogleFonts.roboto(
                              color: AppColors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () {
                          context.read<ProfileCubit>().deleteAccount();
                        },
                        child: Container(
                          height: 56,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: AppColors.red,
                          ),
                          child: Center(
                            child: Text(
                              "Delete Account",
                              style: GoogleFonts.roboto(
                                color: AppColors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      InkWell(
                        onTap: () {
                          if (nameController.text.trim().isEmpty) return;
                          if (phoneController.text.trim().isEmpty ||
                              phoneController.text.length < 10) {
                            return;
                          }

                          final updatedUser = user.copyWith(
                            name: nameController.text,
                            phone: phoneController.text,
                            avaterId: selectedAvatar + 1,
                          );
                          context.read<ProfileCubit>().updateProfile(
                            updatedUser,
                          );
                        },
                        child: Container(
                          height: 56,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: AppColors.primary,
                          ),
                          child: Center(
                            child: Text(
                              "Update data",
                              style: GoogleFonts.roboto(
                                color: AppColors.eerieBlack,
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 25),
                    ],
                  ),
                ),
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  bottom: showAvatars ? 20 : -400,
                  left: 0,
                  right: 0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.darkGray,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      padding: const EdgeInsets.all(16),
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                            ),
                        itemCount: avatars.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedAvatar = index;
                                showAvatars = false;
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: AppColors.primary,
                                  width: 1,
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.asset(
                                  avatars[index],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildTextField(
    BuildContext context, {
    required TextEditingController controller,
    required String icon,
    required String hint,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColors.darkGray,
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: SvgPicture.asset(icon, width: 30, height: 30),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              controller: controller,
              keyboardType: keyboardType,
              style: GoogleFonts.roboto(
                color: AppColors.white,
                fontSize: 20,
                fontWeight: FontWeight.w400,
              ),
              cursorColor: AppColors.primary,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hint,
                hintStyle: const TextStyle(color: Colors.white54),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
