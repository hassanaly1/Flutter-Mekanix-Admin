import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mechanix_admin/data/services/analytics_service.dart';
import 'package:mechanix_admin/data/services/users_service.dart';
import 'package:mechanix_admin/helpers/snackbar.dart';
import 'package:mechanix_admin/helpers/storage_helper.dart';
import 'package:mechanix_admin/models/analytics_count_model.dart';
import 'package:mechanix_admin/models/analytics_model.dart';
import 'package:mechanix_admin/models/user_model.dart';

class UniversalController extends GetxController {
  var isLoading = <bool>[].obs;
  var allUsers = <User>[].obs;
  var pendingUsers = <User>[].obs;
  var acceptedUsers = <User>[].obs;
  AnalyticsData analyticsData = AnalyticsData(
    loginActivity: [],
    accountCreationActivity: [],
    engineActivity: [],
    formBuilderActivity: [],
    templateActivity: [],
  );

  var totalUsersCount = 0.obs;
  var totalVerifiedUsersCount = 0.obs;
  var totalUnverifiedUsersCount = 0.obs;
  var approvedAccountCount = 0.obs;
  var unapprovedAccountCount = 0.obs;
  var generatorCount = 0.obs;
  var compressorCount = 0.obs;
  var formsCount = 0.obs;
  var templatesCount = 0.obs;

  var isLoadingTotalUsers = true.obs;
  var isLoadingVerifiedUsers = true.obs;
  var isLoadingUnverifiedUsers = true.obs;
  var isLoadingApprovedAccount = true.obs;
  var isLoadingUnapprovedAccount = true.obs;
  var isLoadingGeneratorCount = true.obs;
  var isLoadingCompressorCount = true.obs;
  var isLoadingFormsCount = true.obs;
  var isLoadingTemplatesCount = true.obs;

  final UsersService usersService = UsersService();
  final AnalyticsService analyticsService = AnalyticsService();

  @override
  void onInit() async {
    super.onInit();
    // await fetchAllUsers();
    // getActivitiesAnalyticsData();
    getActivitiesCountData();
    // debugPrint('All users: $allUsers');
    // debugPrint('Pending users: $pendingUsers');
    // debugPrint('Accepted users: $acceptedUsers');
  }

  Future<void> getActivitiesAnalyticsData() async {
    final result = await analyticsService.getActivitiesAnalyticsData(
        token: storage.read('token'));
    if (result['success']) {
      analyticsData = result['data'];
    } else {
      print(result['error']);
      MySnackBarsHelper.showError(
          result['error'] ?? 'Error fetching Analytics Data');
    }
  }

  Future<void> getActivitiesCountData() async {
    isLoadingTotalUsers.value = true;
    isLoadingVerifiedUsers.value = true;
    isLoadingUnverifiedUsers.value = true;
    isLoadingApprovedAccount.value = true;
    isLoadingUnapprovedAccount.value = true;
    isLoadingGeneratorCount.value = true;
    isLoadingCompressorCount.value = true;
    isLoadingFormsCount.value = true;
    isLoadingTemplatesCount.value = true;
    final result = await analyticsService.getActivitiesCountData(
        token: storage.read('token'));
    if (result['success']) {
      ActivtiesCount activitiesCount = result['data'];

      // Assign the values to the observable variables
      totalUsersCount.value = activitiesCount.totalUsers ?? 0;
      totalVerifiedUsersCount.value = activitiesCount.verifiedUsers ?? 0;
      totalUnverifiedUsersCount.value = activitiesCount.unverifiedUsers ?? 0;
      approvedAccountCount.value = activitiesCount.approvedAccount ?? 0;
      unapprovedAccountCount.value = activitiesCount.unapprovedAccount ?? 0;
      generatorCount.value = activitiesCount.generatorCount ?? 0;
      compressorCount.value = activitiesCount.compressorCount ?? 0;
      formsCount.value = activitiesCount.formsCount ?? 0;
      templatesCount.value = activitiesCount.templatesCount ?? 0;

      isLoadingTotalUsers.value = false;
      isLoadingVerifiedUsers.value = false;
      isLoadingUnverifiedUsers.value = false;
      isLoadingApprovedAccount.value = false;
      isLoadingUnapprovedAccount.value = false;
      isLoadingGeneratorCount.value = false;
      isLoadingCompressorCount.value = false;
      isLoadingFormsCount.value = false;
      isLoadingTemplatesCount.value = false;
    } else {
      if (result.containsKey('error')) {
        print('Error: ${result['error']}');
      } else {
        print('Failed to get activities count data');
      }
      isLoadingTotalUsers.value = false;
      isLoadingVerifiedUsers.value = false;
      isLoadingUnverifiedUsers.value = false;
      isLoadingApprovedAccount.value = false;
      isLoadingUnapprovedAccount.value = false;
      isLoadingGeneratorCount.value = false;
      isLoadingCompressorCount.value = false;
      isLoadingFormsCount.value = false;
      isLoadingTemplatesCount.value = false;
    }
  }

  void initializeLoadingStates(int count) {
    isLoading.value = List<bool>.filled(count, false);
  }

  Future<void> fetchAllUsers() async {
    final result = await usersService.fetchUsers();
    if (result['success']) {
      allUsers.value =
          result['users'].where((user) => user.isAdmin == false).toList();
      pendingUsers.value =
          allUsers.where((user) => user.isAccountApproved == false).toList();
      acceptedUsers.value =
          allUsers.where((user) => user.isAccountApproved == true).toList();
      initializeLoadingStates(pendingUsers.length);
      initializeLoadingStates(acceptedUsers.length);
    }
  }

  Future<void> approveUser(User user, int index) async {
    debugPrint('ApproveUserFunctionCalled');

    try {
      isLoading[index] = true;
      final result = await usersService.approveUser(user);
      if (result['success']) {
        int index = pendingUsers.indexWhere((u) => u.id == user.id);
        if (index != -1) {
          pendingUsers[index] = User(
            id: user.id,
            firstName: user.firstName,
            lastName: user.lastName,
            email: user.email,
            isEmailVerified: user.isEmailVerified,
            isAdmin: user.isAdmin,
            isOnline: user.isOnline,
            isAccountApproved: true,
            // Mark the user as approved
            profile: user.profile,
          );
          MySnackBarsHelper.showMessage(
              'User ${user.firstName} ${user.lastName} approved successfully.');
          acceptedUsers.add(user);
          pendingUsers.removeAt(index);
        }
      } else {
        MySnackBarsHelper.showError(
            'Something went wrong while approving the user ${user.firstName} ${user.lastName}.');
      }
    } catch (e) {
      MySnackBarsHelper.showError('Something went wrong, please try again.');
    } finally {
      isLoading[index] = false;
    }
  }

  Future<void> deleteUser(User user, int index) async {
    debugPrint('DeleteUserFunctionCalled');

    try {
      isLoading[index] = true;
      final result =
          await usersService.declineUser(user: user, isRejected: false);
      if (result['success']) {
        int index = acceptedUsers.indexWhere((u) => u.id == user.id);
        if (index != -1) {
          // acceptedUsers[index] = User(
          //   id: user.id,
          //   firstName: user.firstName,
          //   lastName: user.lastName,
          //   email: user.email,
          //   isEmailVerified: user.isEmailVerified,
          //   isAdmin: user.isAdmin,
          //   isOnline: user.isOnline,
          //   isAccountApproved: true,
          //   profile: user.profile,
          // );
          MySnackBarsHelper.showMessage(
              'User ${user.firstName} ${user.lastName} removed successfully.');
          acceptedUsers.removeAt(index);
          Get.back();
        }
      } else {
        MySnackBarsHelper.showError(
            'Something went wrong while removing the user ${user.firstName} ${user.lastName}.');
      }
    } catch (e) {
      MySnackBarsHelper.showError('Something went wrong, please try again.');
    } finally {
      isLoading[index] = false;
    }
  }
}
