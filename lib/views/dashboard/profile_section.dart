import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mechanix_admin/helpers/appcolors.dart';
import 'package:mechanix_admin/helpers/custom_button.dart';
import 'package:mechanix_admin/helpers/custom_text.dart';
import 'package:mechanix_admin/helpers/reusable_textfield.dart';
import 'package:mechanix_admin/helpers/storage_helper.dart';
import 'package:mechanix_admin/views/auth/login.dart';

class ProfileSection extends StatelessWidget {
  final SideMenuController sideMenu;
  const ProfileSection({super.key, required this.sideMenu});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        sideMenu.changePage(0);
      },
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: context.width > 800
                ? context.width * 0.13
                : context.width * 0.1),
        child: SizedBox(
          height: context.height,
          width: context.width * 0.25,
          // decoration: reusableContainerDecoration(),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // const ProfileHeader(),
                Container(
                  height: context.height * 0.12,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: AssetImage("assets/images/user2.jpg"))),
                ),
                const SizedBox(height: 12.0),
                CustomTextWidget(
                  text: 'James Anderson',
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                ),
                CustomTextWidget(
                  text: 'Lead of all mechanics Lead of all mechanics',
                  maxLines: 3,
                  fontWeight: FontWeight.w300,
                  textAlign: TextAlign.center,
                  fontSize: 12,
                ),
                Column(
                  children: [
                    ReUsableTextField(hintText: 'jamesanderson@gmail.com'),
                    ReUsableTextField(hintText: '0123456789'),
                    ReUsableTextField(hintText: '*********'),
                    CustomButton(
                      isLoading: false,
                      buttonText: 'Update',
                      onTap: () {},
                      backgroundColor: AppColors.primaryColor,
                      textColor: AppColors.textColor,
                    ),
                    Visibility(
                      visible: context.width > 800,
                      child: CustomButton(
                        isLoading: false,
                        backgroundColor: AppColors.secondaryColor,
                        textColor: AppColors.whiteTextColor,
                        buttonText: 'Logout',
                        onTap: () {
                          storage.remove('token');
                          Get.offAll(() => const LoginScreen());
                          debugPrint(
                              'TokenAtStorageAtLogout: ${storage.read('token')}');
                        },
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.height * 0.25,
      color: Colors.transparent,
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 12.0),
            height: context.height * 0.18,
            decoration: BoxDecoration(
              image: const DecorationImage(
                image: AssetImage('assets/images/home-bg.png'),
                fit: BoxFit.cover,
              ),
              color: AppColors.blueTextColor,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20.0),
                bottomRight: Radius.circular(20.0),
              ),
            ),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [],
                ),
                SizedBox(height: 16.0),
              ],
            ),
          ),
          Positioned(
            right: 0,
            left: 0,
            bottom: 0,
            child: Container(
              height: context.height * 0.15,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: AssetImage("assets/images/user2.jpg"))),
            ),
          ),
        ],
      ),
    );
  }
}

BoxDecoration reusableContainerDecoration() {
  return BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(12.0),
    boxShadow: [
      BoxShadow(
        color: Colors.grey.shade300,
        blurRadius: 5.0,
        spreadRadius: 1.0,
      ),
      const BoxShadow(
        color: Colors.white,
        offset: Offset(0.0, 0.0),
        blurRadius: 0.0,
        spreadRadius: 0.0,
      ),
    ],
  );
}
