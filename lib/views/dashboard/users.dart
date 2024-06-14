import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:mechanix_admin/controllers/universal_controller.dart';
import 'package:mechanix_admin/helpers/appcolors.dart';
import 'package:mechanix_admin/helpers/custom_button.dart';
import 'package:mechanix_admin/helpers/custom_text.dart';
import 'package:mechanix_admin/helpers/reusable_container.dart';
import 'package:mechanix_admin/helpers/reusable_textfield.dart';
import 'package:mechanix_admin/models/user_model.dart';

class UserScreen extends StatelessWidget {
  final SideMenuController sideMenu;

  UserScreen({super.key, required this.sideMenu});

  final UniversalController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        sideMenu.changePage(0);
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          color: Colors.transparent,
          padding: EdgeInsets.symmetric(horizontal: context.width * 0.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: double.infinity,
                child: ReUsableContainer(
                  color: AppColors.primaryColor,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 8.0),
                  child: CustomTextWidget(
                    text: 'Users',
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Obx(
                () => controller.acceptedUsers.isEmpty
                    ? Center(child: CustomTextWidget(text: 'No Users Added'))
                    : Expanded(
                        child: SingleChildScrollView(
                          child: Wrap(
                            spacing: 8.0,
                            runSpacing: 8.0,
                            children: controller.acceptedUsers
                                .asMap()
                                .entries
                                .map((v) {
                              final index = v.key;
                              final user = v.value;
                              return AcceptedUserCard(index: index, user: user);
                            }).toList(),
                          ),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AcceptedUserCard extends StatelessWidget {
  final User user;
  final int index;

  AcceptedUserCard({
    super.key,
    required this.user,
    required this.index,
  });

  final UniversalController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return ReUsableContainer(
      child: ListTile(
        onTap: () {},
        trailing: Wrap(
          children: [
            // IconButton(
            //     onPressed: () => openUserDialog(
            //         context: context,
            //         index: index,
            //         controller: controller,
            //         isUpdate: true),
            //     icon: Icon(FontAwesomeIcons.penToSquare,
            //         color: AppColors.lightTextColor)),
            IconButton(
                onPressed: () => openUserDialog(
                    context: context,
                    index: index,
                    controller: controller,
                    isUpdate: false,
                    user: user),
                icon: const Icon(FontAwesomeIcons.xmark, color: Colors.red)),
          ],
        ),
        leading: const CircleAvatar(
            // user.profile == null
            //     ?
            backgroundImage: AssetImage('assets/images/placeholder-image.png')
                as ImageProvider
            // : NetworkImage(user.profile ?? ''),
            ),
        title: CustomTextWidget(
          text: '${user.firstName} ${user.lastName}',
          fontSize: 14.0,
          fontWeight: FontWeight.w500,
        ),
        subtitle: CustomTextWidget(
          text: user.email ?? '',
          fontSize: 12.0,
          fontWeight: FontWeight.w400,
          textColor: AppColors.lightTextColor,
        ),
      ),
    );
  }

  void openUserDialog({
    required BuildContext context,
    required int index,
    required UniversalController controller,
    required bool isUpdate,
    User? user,
  }) {
    TextEditingController nameController = TextEditingController();
    TextEditingController emailController = TextEditingController();

    if (isUpdate) {
      nameController.text = controller.acceptedUsers[index].firstName ?? '';
      emailController.text = controller.acceptedUsers[index].email ?? '';
    }

    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Dismiss',
      transitionDuration: const Duration(milliseconds: 400),
      pageBuilder: (context, animation, secondaryAnimation) => Container(),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return ScaleTransition(
          scale: Tween<double>(begin: 0.5, end: 1.0).animate(animation),
          child: FadeTransition(
            opacity: Tween<double>(begin: 0.5, end: 1.0).animate(animation),
            child: AlertDialog(
              scrollable: true,
              backgroundColor: Colors.transparent,
              content: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                    horizontal: 8.0, vertical: context.height * 0.02),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      Color.fromRGBO(255, 220, 105, 0.4),
                      Color.fromRGBO(86, 127, 255, 0.4),
                    ],
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(12.0)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black26,
                        blurRadius: 5.0,
                        spreadRadius: 5.0),
                    BoxShadow(
                        color: Colors.white,
                        offset: Offset(0.0, 0.0),
                        blurRadius: 0.0,
                        spreadRadius: 0.0)
                  ],
                ),
                child: Column(
                  children: [
                    CustomTextWidget(
                      text:
                          isUpdate ? 'Update User Information' : 'Remove User',
                      textColor: AppColors.textColor,
                      fontWeight: FontWeight.w400,
                    ),
                    const SizedBox(height: 12.0),
                    if (isUpdate)
                      Container(
                        height: context.height * 0.1,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: AssetImage("assets/images/user2.jpg")),
                        ),
                      ),
                    if (isUpdate)
                      Column(
                        children: [
                          ReUsableTextField(controller: nameController),
                          ReUsableTextField(controller: emailController),
                        ],
                      ),
                    if (!isUpdate)
                      CustomTextWidget(
                        text:
                            'This action will permanently remove ${user?.firstName} ${user?.lastName} and their data. This cannot be undone.',
                        maxLines: 2,
                        fontSize: 12.0,
                        textAlign: TextAlign.center,
                        textColor: AppColors.textColor,
                      ),
                    if (!isUpdate)
                      CustomTextWidget(
                        text: 'Are you sure you want to proceed?',
                        maxLines: 2,
                        fontWeight: FontWeight.w400,
                        textAlign: TextAlign.center,
                        textColor: AppColors.textColor,
                      ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomButton(
                          isLoading: false,
                          // isLoading: controller.isLoading[index],
                          backgroundColor:
                              isUpdate ? AppColors.primaryColor : Colors.red,
                          textColor: AppColors.textColor,
                          buttonText: isUpdate ? 'Update' : 'Remove',
                          fontSize: 12.0,
                          onTap: () {
                            if (isUpdate) {
                              controller.acceptedUsers[index].firstName =
                                  nameController.text.trim();
                              controller.acceptedUsers[index].email =
                                  emailController.text.trim();
                              controller.acceptedUsers.refresh();
                              Get.back();
                            } else if (user != null) {
                              controller.deleteUser(user, index);
                              Get.back();
                            }
                          },
                        ),
                        CustomButton(
                          isLoading: false,
                          backgroundColor: AppColors.secondaryColor,
                          textColor: AppColors.whiteTextColor,
                          buttonText: 'Cancel',
                          fontSize: 12.0,
                          onTap: () => Get.back(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
