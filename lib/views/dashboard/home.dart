import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mechanix_admin/helpers/appcolors.dart';
import 'package:mechanix_admin/helpers/custom_text.dart';
import 'package:mechanix_admin/helpers/reusable_container.dart';

class HomeSection extends StatefulWidget {
  final SideMenuController sideMenu;

  const HomeSection({
    super.key,
    required this.sideMenu,
  });

  @override
  State<HomeSection> createState() => _HomeSectionState();
}

class _HomeSectionState extends State<HomeSection> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        color: Colors.transparent,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Wrap(
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                runAlignment: WrapAlignment.center,
                children: [
                  buildReUsableContainer(
                    context: context,
                    color: AppColors.chartYellowColor,
                    onTap: () => widget.sideMenu.changePage(3),
                    text: 'Total Users',
                    width: 220,
                    height: context.height * 0.15,
                    textAlign: TextAlign.center,
                  ),
                  buildReUsableContainer(
                    context: context,
                    color: AppColors.chartOrangeColor,
                    onTap: () => widget.sideMenu.changePage(4),
                    text: 'Verified Users',
                    width: 220,
                    height: context.height * 0.15,
                    textAlign: TextAlign.start,
                  ),
                  buildReUsableContainer(
                    context: context,
                    color: AppColors.chartGreenColor,
                    onTap: () => widget.sideMenu.changePage(4),
                    text: 'Unverified Users',
                    width: 220,
                    height: context.height * 0.15,
                    textAlign: TextAlign.start,
                  ),
                  buildReUsableContainer(
                    context: context,
                    color: AppColors.chartPurpleColor,
                    onTap: () => widget.sideMenu.changePage(2),
                    text: 'Approved Account',
                    width: 220,
                    height: context.height * 0.15,
                    textAlign: TextAlign.center,
                  ),
                  buildReUsableContainer(
                    context: context,
                    color: AppColors.chartOrangeColor,
                    onTap: () => widget.sideMenu.changePage(3),
                    text: 'Rejected Account',
                    width: 220,
                    height: context.height * 0.15,
                    textAlign: TextAlign.center,
                  ),
                  buildReUsableContainer(
                    context: context,
                    color: AppColors.chartYellowColor,
                    onTap: () => widget.sideMenu.changePage(4),
                    text: 'Total Generator Engines',
                    width: 220,
                    height: context.height * 0.15,
                    textAlign: TextAlign.start,
                  ),
                  buildReUsableContainer(
                    context: context,
                    color: AppColors.chartPurpleColor,
                    onTap: () => widget.sideMenu.changePage(4),
                    text: 'Total Compressor Engines',
                    width: 220,
                    height: context.height * 0.15,
                    textAlign: TextAlign.start,
                  ),
                  buildReUsableContainer(
                    context: context,
                    color: AppColors.chartGreenColor,
                    onTap: () => widget.sideMenu.changePage(2),
                    text: 'Total Generator Tasks',
                    width: 220,
                    height: context.height * 0.15,
                    textAlign: TextAlign.center,
                  ),
                  buildReUsableContainer(
                    context: context,
                    color: AppColors.chartOrangeColor,
                    onTap: () => widget.sideMenu.changePage(3),
                    text: 'Total Compressor Tasks',
                    width: 220,
                    height: context.height * 0.15,
                    textAlign: TextAlign.center,
                  ),
                  buildReUsableContainer(
                    context: context,
                    color: AppColors.chartGreenColor,
                    onTap: () => widget.sideMenu.changePage(2),
                    text: 'Total Assembly Tasks',
                    width: 220,
                    height: context.height * 0.15,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              // Center(
              //   child: Wrap(
              //     alignment: WrapAlignment.center,
              //     crossAxisAlignment: WrapCrossAlignment.center,
              //     runAlignment: WrapAlignment.center,
              //     children: [
              //       SizedBox(height: 350, width: 350, child: BarChartSample1()),
              //       const SizedBox(
              //           height: 350, width: 350, child: PieChartSample2()),
              //     ],
              //   ),
              // ),
              // BarChartSample6(),
            ],
          ),
        ),
      ),
    );
  }
}

Widget buildReUsableContainer({
  required BuildContext context,
  required Color color,
  VoidCallback? onTap,
  required String text,
  required double width,
  required double height,
  required TextAlign textAlign,
}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: ReUsableContainer(
      color: color,
      onTap: onTap,
      width: width,
      height: height,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomTextWidget(
              text: text,
              fontSize: 14.0,
              fontWeight: FontWeight.w600,
              textAlign: TextAlign.center,
              textColor: AppColors.contentColorBlack.withOpacity(0.8),
              maxLines: 2,
            ),
            CustomTextWidget(
              text: '450',
              fontSize: 30.0,
              fontWeight: FontWeight.w600,
              textAlign: TextAlign.center,
              maxLines: 2,
            ),
          ],
        ),
      ),
    ),
  );
}
