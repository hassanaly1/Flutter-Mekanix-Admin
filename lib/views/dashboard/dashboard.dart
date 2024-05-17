import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mechanix_admin/controllers/dashboard_controller.dart';
import 'package:mechanix_admin/controllers/universal_controller.dart';
import 'package:mechanix_admin/helpers/custom_text.dart';
import 'package:mechanix_admin/helpers/profile_avatar.dart';
import 'package:mechanix_admin/views/auth/login.dart';
import 'package:mechanix_admin/views/dashboard/right_side.dart';
import 'package:mechanix_admin/views/dashboard/side_menu.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with TickerProviderStateMixin {
  final DashboardController _controller = Get.put(DashboardController());
  final UniversalController _universalController =
      Get.put(UniversalController());

  @override
  void initState() {
    super.initState();
    _controller.tabController = TabController(
      initialIndex: 0,
      length: 6,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 7,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset('assets/images/home-bg.png', fit: BoxFit.fill),
            Scaffold(
              backgroundColor: Colors.transparent,
              body: Column(
                children: [
                  HomeAppbar(sideMenu: _controller.sideMenu),
                  Expanded(
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            Color.fromRGBO(255, 220, 105, 0.4),
                            Color.fromRGBO(86, 127, 255, 0.4),
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 5.0,
                            spreadRadius: 5.0,
                          ),
                          BoxShadow(
                            color: Colors.white,
                            offset: Offset(0.0, 0.0),
                            blurRadius: 0.0,
                            spreadRadius: 0.0,
                          ),
                        ],
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(22.0),
                          topRight: Radius.circular(22.0),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Visibility(
                            visible: context.width > 800,
                            child: SideMenuCard(sideMenu: _controller.sideMenu),
                          ),
                          RightSideWidget(
                            pageController: _controller.pageController,
                            sideMenu: _controller.sideMenu,
                            tabController: _controller.tabController,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HomeAppbar extends StatelessWidget {
  final SideMenuController sideMenu;

  HomeAppbar({
    super.key,
    required this.sideMenu,
  });

  final DashboardController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    // var currentPage = sideMenu.currentPage;

    return SizedBox(
      height:
          context.width > 800 ? context.height * 0.15 : context.height * 0.15,
      child: context.width > 800
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    context.width > 800
                        ? Image.asset(
                            'assets/images/app-logo-white.png',
                            height: context.height * 0.1,
                            fit: BoxFit.cover,
                          )
                        : IconButton(
                            onPressed: () => sideMenu.changePage(1),
                            icon: const Icon(Icons.arrow_back_rounded,
                                color: Colors.white70)),
                    Obx(
                      () => CustomTextWidget(
                        text: controller.currentPage.value == 0
                            ? 'Admin Panel'
                            : controller.currentPage.value == 2
                                ? 'Registrations'
                                : controller.currentPage.value == 3
                                    ? 'Users'
                                    : controller.currentPage.value == 4
                                        ? 'Subscriptions'
                                        : controller.currentPage.value == 6
                                            ? 'Profile'
                                            : '',
                        textColor: Colors.white,
                        fontSize: context.width > 800 ? 20.0 : 18.0,
                        fontWeight: FontWeight.w600,
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: context.width > 800
                      ? Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey.shade200,
                          ),
                          child: IconButton(
                            onPressed: () {
                              Get.offAll(const LoginScreen());
                            },
                            icon: const Icon(Icons.logout_rounded),
                          ),
                        )
                      : ProfileAvatar(
                          onTap: () => sideMenu.changePage(7),
                        ),
                ),
              ],
            )
          : Padding(
              padding: const EdgeInsets.all(4.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      context.width > 800
                          ? Image.asset(
                              'assets/images/app-logo-white.png',
                              height: context.height * 0.1,
                              fit: BoxFit.cover,
                            )
                          : Obx(
                              () => Visibility(
                                visible: controller.currentPage.value == 0
                                    ? false
                                    : true,
                                child: IconButton(
                                  onPressed: () {
                                    controller.currentPage.value == 0
                                        ? null
                                        : sideMenu.changePage(0);
                                  },
                                  icon: Icon(Icons.arrow_back_rounded,
                                      color: controller.currentPage.value == 0
                                          ? Colors.transparent
                                          : Colors.white70),
                                ),
                              ),
                            ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ProfileAvatar(
                          onTap: () => sideMenu.changePage(6),
                        ),
                      ),
                    ],
                  ),
                  Obx(
                    () => CustomTextWidget(
                      text: controller.currentPage.value == 0
                          ? 'Admin Panel'
                          : controller.currentPage.value == 2
                              ? 'Registrations'
                              : controller.currentPage.value == 3
                                  ? 'Users'
                                  : controller.currentPage.value == 4
                                      ? 'Subscriptions'
                                      : controller.currentPage.value == 6
                                          ? 'Profile'
                                          : '',
                      textColor: Colors.white,
                      fontSize: context.width > 800 ? 20.0 : 18.0,
                      fontWeight: FontWeight.w600,
                      maxLines: 2,
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
