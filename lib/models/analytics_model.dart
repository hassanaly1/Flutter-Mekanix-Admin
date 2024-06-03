class AnalyticsData {
  final List<Activity> loginActivity;
  final List<Activity> accountCreationActivity;
  final List<Activity> engineTask;
  final List<Activity> compressorTask;

  AnalyticsData({
    required this.loginActivity,
    required this.accountCreationActivity,
    required this.engineTask,
    required this.compressorTask,
  });

  factory AnalyticsData.fromJson(Map<String, dynamic> json) {
    return AnalyticsData(
      loginActivity: (json['login_activity'] as List<dynamic>?)
              ?.map((e) => Activity.fromJson(e))
              .toList() ??
          [],
      accountCreationActivity:
          (json['account_creation_activity'] as List<dynamic>?)
                  ?.map((e) => Activity.fromJson(e))
                  .toList() ??
              [],
      engineTask: (json['engine_task'] as List<dynamic>?)
              ?.map((e) => Activity.fromJson(e))
              .toList() ??
          [],
      compressorTask: (json['compressor_task'] as List<dynamic>?)
              ?.map((e) => Activity.fromJson(e))
              .toList() ??
          [],
    );
  }
}

class Activity {
  final int count;
  final String month;

  Activity({required this.count, required this.month});

  factory Activity.fromJson(Map<String, dynamic> json) {
    return Activity(
      count: json['login_count'] ??
          json['account_creation_count'] ??
          json['task_count'] ??
          json['compressor_count'] ??
          0,
      month: json['month'] ?? '',
    );
  }
}
