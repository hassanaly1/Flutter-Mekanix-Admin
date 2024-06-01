// To parse this JSON data, do
//
//     final userActivities = userActivitiesFromJson(jsonString);

import 'dart:convert';

UserActivities userActivitiesFromJson(String str) =>
    UserActivities.fromJson(json.decode(str));

String userActivitiesToJson(UserActivities data) => json.encode(data.toJson());

class UserActivities {
  List<LoginActivity>? loginActivity;
  List<AccountCreationActivity>? accountCreationActivity;
  List<EngineAssemblyReportV>? engineAssemblyReportV12;
  List<EngineAssemblyReportV>? engineAssemblyReportV16;
  List<EngineAssemblyReportL7042Glc14871>? engineAssemblyReportL7042Glc14871;
  List<EngineAssemblyReportV>? engineAssemblyReportV8;
  List<Task>? tasks;

  UserActivities({
    this.loginActivity,
    this.accountCreationActivity,
    this.engineAssemblyReportV12,
    this.engineAssemblyReportV16,
    this.engineAssemblyReportL7042Glc14871,
    this.engineAssemblyReportV8,
    this.tasks,
  });

  factory UserActivities.fromJson(Map<String, dynamic> json) => UserActivities(
        loginActivity: json["login_activity"] == null
            ? []
            : List<LoginActivity>.from(
                json["login_activity"]!.map((x) => LoginActivity.fromJson(x))),
        accountCreationActivity: json["account_creation_activity"] == null
            ? []
            : List<AccountCreationActivity>.from(
                json["account_creation_activity"]!
                    .map((x) => AccountCreationActivity.fromJson(x))),
        engineAssemblyReportV12: json["engine_assembly_report_v12"] == null
            ? []
            : List<EngineAssemblyReportV>.from(
                json["engine_assembly_report_v12"]!
                    .map((x) => EngineAssemblyReportV.fromJson(x))),
        engineAssemblyReportV16: json["engine_assembly_report_v16"] == null
            ? []
            : List<EngineAssemblyReportV>.from(
                json["engine_assembly_report_v16"]!
                    .map((x) => EngineAssemblyReportV.fromJson(x))),
        engineAssemblyReportL7042Glc14871:
            json["engineAssembly_report_L7042GLC14871"] == null
                ? []
                : List<EngineAssemblyReportL7042Glc14871>.from(
                    json["engineAssembly_report_L7042GLC14871"]!.map(
                        (x) => EngineAssemblyReportL7042Glc14871.fromJson(x))),
        engineAssemblyReportV8: json["engine_assembly_report_v8"] == null
            ? []
            : List<EngineAssemblyReportV>.from(
                json["engine_assembly_report_v8"]!
                    .map((x) => EngineAssemblyReportV.fromJson(x))),
        tasks: json["tasks"] == null
            ? []
            : List<Task>.from(json["tasks"]!.map((x) => Task.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "login_activity": loginActivity == null
            ? []
            : List<dynamic>.from(loginActivity!.map((x) => x.toJson())),
        "account_creation_activity": accountCreationActivity == null
            ? []
            : List<dynamic>.from(
                accountCreationActivity!.map((x) => x.toJson())),
        "engine_assembly_report_v12": engineAssemblyReportV12 == null
            ? []
            : List<dynamic>.from(
                engineAssemblyReportV12!.map((x) => x.toJson())),
        "engine_assembly_report_v16": engineAssemblyReportV16 == null
            ? []
            : List<dynamic>.from(
                engineAssemblyReportV16!.map((x) => x.toJson())),
        "engineAssembly_report_L7042GLC14871":
            engineAssemblyReportL7042Glc14871 == null
                ? []
                : List<dynamic>.from(
                    engineAssemblyReportL7042Glc14871!.map((x) => x.toJson())),
        "engine_assembly_report_v8": engineAssemblyReportV8 == null
            ? []
            : List<dynamic>.from(
                engineAssemblyReportV8!.map((x) => x.toJson())),
        "tasks": tasks == null
            ? []
            : List<dynamic>.from(tasks!.map((x) => x.toJson())),
      };
}

class AccountCreationActivity {
  int? accountCreationCount;
  String? month;

  AccountCreationActivity({
    this.accountCreationCount,
    this.month,
  });

  factory AccountCreationActivity.fromJson(Map<String, dynamic> json) =>
      AccountCreationActivity(
        accountCreationCount: json["account_creation_count"],
        month: json["month"],
      );

  Map<String, dynamic> toJson() => {
        "account_creation_count": accountCreationCount,
        "month": month,
      };
}

class EngineAssemblyReportL7042Glc14871 {
  int? reportCount;
  int? month;

  EngineAssemblyReportL7042Glc14871({
    this.reportCount,
    this.month,
  });

  factory EngineAssemblyReportL7042Glc14871.fromJson(
          Map<String, dynamic> json) =>
      EngineAssemblyReportL7042Glc14871(
        reportCount: json["report_count"],
        month: json["month"],
      );

  Map<String, dynamic> toJson() => {
        "report_count": reportCount,
        "month": month,
      };
}

class EngineAssemblyReportV {
  int? reportCount;
  String? month;

  EngineAssemblyReportV({
    this.reportCount,
    this.month,
  });

  factory EngineAssemblyReportV.fromJson(Map<String, dynamic> json) =>
      EngineAssemblyReportV(
        reportCount: json["report_count"],
        month: json["month"],
      );

  Map<String, dynamic> toJson() => {
        "report_count": reportCount,
        "month": month,
      };
}

class LoginActivity {
  int? loginCount;
  String? month;

  LoginActivity({
    this.loginCount,
    this.month,
  });

  factory LoginActivity.fromJson(Map<String, dynamic> json) => LoginActivity(
        loginCount: json["login_count"],
        month: json["month"],
      );

  Map<String, dynamic> toJson() => {
        "login_count": loginCount,
        "month": month,
      };
}

class Task {
  int? taskCount;
  String? month;

  Task({
    this.taskCount,
    this.month,
  });

  factory Task.fromJson(Map<String, dynamic> json) => Task(
        taskCount: json["task_count"],
        month: json["month"],
      );

  Map<String, dynamic> toJson() => {
        "task_count": taskCount,
        "month": month,
      };
}
