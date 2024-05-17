import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:get/get.dart';
import 'package:mechanix_admin/helpers/custom_text.dart';
import 'package:mechanix_admin/helpers/reusable_container.dart';
import 'package:flutter/material.dart';

class HomeSection extends StatelessWidget {
  final SideMenuController sideMenu;
  const HomeSection({
    super.key,
    required this.sideMenu,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        color: Colors.transparent,
        padding: EdgeInsets.symmetric(horizontal: context.width * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextWidget(
              text: 'Users Management',
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
              textAlign: TextAlign.start,
            ),
            const Divider(color: Colors.black54, thickness: 2.0),
            ReUsableContainer(
                onTap: () => sideMenu.changePage(2),
                width: double.infinity,
                height: context.height * 0.15,
                child: Center(
                  child: CustomTextWidget(
                    text: 'Registrations',
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                  ),
                )),
            ReUsableContainer(
                onTap: () => sideMenu.changePage(3),
                width: double.infinity,
                height: context.height * 0.15,
                child: Center(
                  child: CustomTextWidget(
                    text: 'Users',
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                  ),
                )),
            CustomTextWidget(
              text: 'Subscriptions Management',
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
              textAlign: TextAlign.center,
            ),
            const Divider(color: Colors.black54, thickness: 2.0),
            ReUsableContainer(
                onTap: () => sideMenu.changePage(4),
                width: double.infinity,
                height: context.height * 0.15,
                child: Center(
                  child: CustomTextWidget(
                    text: 'Subscriptions',
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                    textAlign: TextAlign.start,
                    maxLines: 2,
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
