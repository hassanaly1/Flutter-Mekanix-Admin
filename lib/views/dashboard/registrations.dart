import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mechanix_admin/controllers/universal_controller.dart';
import 'package:mechanix_admin/helpers/appcolors.dart';
import 'package:mechanix_admin/helpers/custom_button.dart';
import 'package:mechanix_admin/helpers/custom_text.dart';
import 'package:mechanix_admin/helpers/reusable_container.dart';
import 'package:mechanix_admin/models/user_model.dart';

class RegistrationScreen extends StatefulWidget {
  final SideMenuController sideMenu;

  const RegistrationScreen({super.key, required this.sideMenu});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final UniversalController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        widget.sideMenu.changePage(0);
      },
      child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
              color: Colors.transparent,
              padding: EdgeInsets.symmetric(horizontal: context.width * 0.04),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                        width: double.infinity,
                        child: ReUsableContainer(
                            color: AppColors.primaryColor,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 8.0),
                            child: CustomTextWidget(
                                text: 'New Registrations Requests',
                                fontSize: 16.0,
                                fontWeight: FontWeight.w600,
                                textAlign: TextAlign.center))),
                    Obx(() => controller.pendingUsers.isEmpty
                        ? Center(
                            child: CustomTextWidget(text: 'No Users Requests'))
                        : Expanded(
                            child: SingleChildScrollView(
                                child: Wrap(
                            spacing: 8.0,
                            runSpacing: 8.0,
                            children: controller.pendingUsers
                                .asMap()
                                .entries
                                .map((v) {
                              final index = v.key;
                              final user = v.value;
                              return Container(
                                  color: Colors.grey.shade100,
                                  child:
                                      CustomUserCard(index: index, user: user));
                            }).toList(),
                          ))))
                  ]))),
    );
  }
}

class CustomUserCard extends StatelessWidget {
  final User user;
  final int index;

  CustomUserCard({super.key, required this.user, required this.index});

  final UniversalController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        height: context.width > 270 ? 200 : 230,
        width: 250,
        color: Colors.transparent,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                height: context.width > 270 ? 150 : 170,
                decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(20.0)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomTextWidget(
                      text: user.firstName ?? '',
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500,
                    ),
                    CustomTextWidget(
                      text: user.email ?? '',
                      fontSize: 12.0,
                      fontWeight: FontWeight.w400,
                      textColor: AppColors.lightTextColor,
                    ),
                    context.width > 270
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Obx(
                                () => CustomButton(
                                  isLoading: controller.isLoading[index],
                                  width: context.width > 350 ? 100 : 70,
                                  backgroundColor: AppColors.primaryColor,
                                  buttonText: 'Accept',
                                  fontSize: context.width > 350 ? 14 : 10,
                                  onTap: () {
                                    controller.approveUser(user, index);
                                  },
                                ),
                              ),
                              CustomButton(
                                isLoading: false,
                                backgroundColor: AppColors.secondaryColor,
                                textColor: AppColors.whiteTextColor,
                                width: context.width > 350 ? 100 : 70,
                                buttonText: 'Reject',
                                fontSize: context.width > 350 ? 14 : 10,
                                onTap: () =>
                                    controller.pendingUsers.removeAt(index),
                              )
                            ],
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Obx(
                                () => CustomButton(
                                  isLoading: controller.isLoading[index],
                                  width: context.width > 350 ? 100 : 70,
                                  backgroundColor: AppColors.primaryColor,
                                  buttonText: 'Accept',
                                  fontSize: context.width > 350 ? 14 : 10,
                                  onTap: () {
                                    controller.approveUser(user, index);
                                  },
                                ),
                              ),
                              CustomButton(
                                isLoading: false,
                                backgroundColor: AppColors.secondaryColor,
                                textColor: Colors.white70,
                                width: context.width > 350 ? 100 : 70,
                                buttonText: 'Reject',
                                fontSize: context.width > 350 ? 14 : 10,
                                onTap: () =>
                                    controller.pendingUsers.removeAt(index),
                              )
                            ],
                          ),
                  ],
                ),
              ),
            ),
            Positioned(
              right: 0,
              left: 0,
              top: 0,
              child: Container(
                height: 80,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage(user.profile ?? ''),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
