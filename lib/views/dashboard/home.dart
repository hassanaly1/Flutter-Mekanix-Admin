import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:mechanix_admin/controllers/universal_controller.dart';
import 'package:mechanix_admin/helpers/appcolors.dart';
import 'package:mechanix_admin/helpers/custom_text.dart';
import 'package:mechanix_admin/helpers/reusable_container.dart';
import 'package:mechanix_admin/models/analytics_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

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
  final UniversalController controller = Get.find();
  List<_ChartData> chartData = [];

  @override
  void initState() {
    super.initState();
    controller.getActivitiesAnalyticsData().then((_) {
      setState(() {
        chartData = _prepareChartData(controller.analyticsData);
      });
    });
  }

  List<_ChartData> _prepareChartData(AnalyticsData analyticsData) {
    final List<String> allMonths = [
      "Jan",
      "Feb",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "Sept",
      "Oct",
      "Nov",
      "Dec"
    ];

    final Map<String, _ChartData> dataMap = {
      for (var month in allMonths) month: _ChartData(month, 0, 0, 0, 0)
    };

    for (var activity in analyticsData.loginActivity) {
      dataMap[activity.month] = dataMap[activity.month]?.copyWith(
            loginActivity: activity.count,
          ) ??
          _ChartData(activity.month, activity.count, 0, 0, 0);
    }

    for (var activity in analyticsData.accountCreationActivity) {
      dataMap[activity.month] = dataMap[activity.month]?.copyWith(
            accountCreationActivity: activity.count,
          ) ??
          _ChartData(activity.month, 0, activity.count, 0, 0);
    }

    for (var activity in analyticsData.engineTask) {
      dataMap[activity.month] = dataMap[activity.month]?.copyWith(
            engineTask: activity.count,
          ) ??
          _ChartData(activity.month, 0, 0, activity.count, 0);
    }

    for (var activity in analyticsData.compressorTask) {
      dataMap[activity.month] = dataMap[activity.month]?.copyWith(
            compressorTask: activity.count,
          ) ??
          _ChartData(activity.month, 0, 0, 0, activity.count);
    }

    return dataMap.values.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 16.0),
      child: Container(
        height: context.height * 0.5,
        color: Colors.transparent,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: context.width * 0.05),
                child: ReUsableContainer(
                  color: Colors.grey.shade100,
                  height: context.height * 0.5,
                  child: SfCartesianChart(
                    plotAreaBorderWidth: 1,
                    enableAxisAnimation: true,
                    enableMultiSelection: true,
                    enableSideBySideSeriesPlacement: true,
                    title: const ChartTitle(
                        text: 'Yearly Analytics Data',
                        textStyle:
                            TextStyle(fontSize: 14, fontFamily: 'Poppins')),
                    legend: const Legend(isVisible: true),
                    primaryXAxis: const CategoryAxis(
                      majorGridLines: MajorGridLines(width: 1),
                      labelRotation: 0,
                    ),
                    primaryYAxis: const NumericAxis(
                      rangePadding: ChartRangePadding.none,
                      axisLine: AxisLine(width: 0),
                      majorTickLines: MajorTickLines(size: 6),
                    ),
                    series: _getStackedLineSeries(),
                    tooltipBehavior: TooltipBehavior(enable: true),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<CartesianSeries<_ChartData, String>> _getStackedLineSeries() {
    return <CartesianSeries<_ChartData, String>>[
      StackedLineSeries<_ChartData, String>(
        dataSource: chartData,
        xValueMapper: (_ChartData data, _) => data.month,
        yValueMapper: (_ChartData data, _) => data.loginActivity,
        name: 'Login Activity',
        markerSettings: const MarkerSettings(isVisible: true),
      ),
      StackedLineSeries<_ChartData, String>(
        dataSource: chartData,
        xValueMapper: (_ChartData data, _) => data.month,
        yValueMapper: (_ChartData data, _) => data.accountCreationActivity,
        name: 'Account Creation',
        markerSettings: const MarkerSettings(isVisible: true),
      ),
      StackedLineSeries<_ChartData, String>(
        dataSource: chartData,
        xValueMapper: (_ChartData data, _) => data.month,
        yValueMapper: (_ChartData data, _) => data.engineTask,
        name: 'Engine Task',
        markerSettings: const MarkerSettings(isVisible: true),
      ),
      StackedLineSeries<_ChartData, String>(
        dataSource: chartData,
        xValueMapper: (_ChartData data, _) => data.month,
        yValueMapper: (_ChartData data, _) => data.compressorTask,
        name: 'Compressor Task',
        markerSettings: const MarkerSettings(isVisible: true),
      ),
    ];
  }

  Widget buildContainer({
    required String text,
    required RxInt value,
    required bool isLoading,
    required IconData icon,
    VoidCallback? onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: ReUsableContainer(
        color: Colors.grey.shade100,
        borderRadius: 18.0,
        onTap: onTap,
        width: 180,
        height: context.height * 0.18,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(icon),
              CustomTextWidget(
                text: text,
                fontSize: 14.0,
                fontWeight: FontWeight.w600,
                textAlign: TextAlign.center,
                textColor: AppColors.contentColorBlack.withOpacity(0.8),
                maxLines: 2,
              ),
              isLoading
                  ? SpinKitThreeBounce(
                      color: AppColors.secondaryColor,
                      size: 25.0,
                    )
                  : CustomTextWidget(
                      text: '${value.value}',
                      fontSize: 26.0,
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
}

class _ChartData {
  _ChartData(this.month, this.loginActivity, this.accountCreationActivity,
      this.engineTask, this.compressorTask);

  final String month;
  final num loginActivity;
  final num accountCreationActivity;
  final num engineTask;
  final num compressorTask;

  _ChartData copyWith(
      {num? loginActivity,
      num? accountCreationActivity,
      num? engineTask,
      num? compressorTask}) {
    return _ChartData(
      month,
      loginActivity ?? this.loginActivity,
      accountCreationActivity ?? this.accountCreationActivity,
      engineTask ?? this.engineTask,
      compressorTask ?? this.compressorTask,
    );
  }
}
