import 'dart:convert';

ActivtiesCount activtiesCountFromJson(String str) =>
    ActivtiesCount.fromJson(json.decode(str));

String activtiesCountToJson(ActivtiesCount data) => json.encode(data.toJson());

class ActivtiesCount {
  int? totalUsers;
  int? verifiedUsers;
  int? unverifiedUsers;
  int? approvedAccount;
  int? unapprovedAccount;
  int? generatorCount;
  int? compressorCount;
  int? engineAssemblyReportContCount;
  int? taskCount;
  int? compressorTaskCount;

  ActivtiesCount({
    this.totalUsers,
    this.verifiedUsers,
    this.unverifiedUsers,
    this.approvedAccount,
    this.unapprovedAccount,
    this.generatorCount,
    this.compressorCount,
    this.engineAssemblyReportContCount,
    this.taskCount,
    this.compressorTaskCount,
  });

  factory ActivtiesCount.fromJson(Map<String, dynamic> json) {
    return ActivtiesCount(
      totalUsers: json["total_users"],
      verifiedUsers: json["verified_users"],
      unverifiedUsers: json["unverified_users"],
      approvedAccount: json["approved_account"],
      unapprovedAccount: json["unapproved_account"],
      generatorCount: json["generator_count"],
      compressorCount: json["compressor_count"],
      engineAssemblyReportContCount: json["engine_assembly_report_cont_count"],
      taskCount: json["task_count"],
      compressorTaskCount: json["compressor_task_count"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "total_users": totalUsers,
      "verified_users": verifiedUsers,
      "unverified_users": unverifiedUsers,
      "approved_account": approvedAccount,
      "unapproved_account": unapprovedAccount,
      "generator_count": generatorCount,
      "compressor_count": compressorCount,
      "engine_assembly_report_cont_count": engineAssemblyReportContCount,
      "task_count": taskCount,
      "compressor_task_count": compressorTaskCount,
    };
  }
}
