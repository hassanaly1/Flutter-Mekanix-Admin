import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mechanix_admin/data/services/analytics_service.dart';
import 'package:mechanix_admin/data/services/users_service.dart';
import 'package:mechanix_admin/helpers/snackbar.dart';
import 'package:mechanix_admin/helpers/storage_helper.dart';
import 'package:mechanix_admin/models/analytics_count_model.dart';
import 'package:mechanix_admin/models/analytics_model.dart';
import 'package:mechanix_admin/models/user_model.dart';

class UniversalController extends GetxController {
  var isApproveLoading = <bool>[].obs;
  var isRejectLoading = <bool>[].obs;
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

  XFile? userImage;
  RxString userImageURL = ''.obs;
  Uint8List? userImageInBytes;
  RxMap userInfo = {}.obs;

  set setUserImageUrl(String value) {
    userImageURL.value = value;
    update();
  }

  @override
  void onInit() async {
    super.onInit();
    fetchAllUsers();
    initializeLoadingStates(pendingUsers.length);
    getActivitiesAnalyticsData();
    getActivitiesCountData();
    userInfo.value = storage.read('user_info') ?? {};
    userImageURL.value = storage.read('user_info')['profile'];
  }

  updateUserInfo(Map<String, dynamic> userInfo) {
    this.userInfo.value = userInfo;
    storage.write('user_info', userInfo);
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
    isApproveLoading.value = List<bool>.filled(count, false);
    isRejectLoading.value = List<bool>.filled(count, false);
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
    }
  }

  Future<void> approveUser(User user, int index) async {
    debugPrint('ApproveUserFunctionCalled');
    isApproveLoading[index] = true;
    update();

    try {
      final result = await UsersService().approveUser(user);
      debugPrint('Server response: $result');

      if (result['success']) {
        int userIndex = pendingUsers.indexWhere((u) => u.id == user.id);
        if (userIndex != -1) {
          MySnackBarsHelper.showMessage(
              'User ${user.firstName} ${user.lastName} approved successfully.');
          pendingUsers[userIndex] = User(
            id: user.id,
            firstName: user.firstName,
            lastName: user.lastName,
            email: user.email,
            isEmailVerified: user.isEmailVerified,
            isAdmin: user.isAdmin,
            isOnline: user.isOnline,
            isAccountApproved: true,
            profile: user.profile,
          );
          acceptedUsers.add(pendingUsers[userIndex]);
          pendingUsers.removeAt(userIndex);
          update();
        }
      } else {
        MySnackBarsHelper.showError(
            'Something went wrong while approving the user ${user.firstName} ${user.lastName}.');
      }
    } catch (e) {
      debugPrint('Error occurred: $e');
      MySnackBarsHelper.showError('Something went wrong, please try again.');
    } finally {
      isApproveLoading[index] = false;
      update();
    }
  }

  Future<void> deleteUserInRegistrationScreen(User user, int index) async {
    isRejectLoading[index] = true;
    update();
    try {
      final response = await usersService.deleteUser(user.id ?? '');

      if (response['success']) {
        if (index >= 0 && index < pendingUsers.length) {
          pendingUsers.removeAt(index);
          MySnackBarsHelper.showMessage(
              'User ${user.firstName} ${user.lastName} removed successfully.');
        } else {
          MySnackBarsHelper.showError(
              'Something went wrong, please try again.');
        }
      } else {
        MySnackBarsHelper.showError('Something went wrong, please try again.');
      }
    } catch (e) {
      MySnackBarsHelper.showError('Something went wrong, please try again.');
    } finally {
      isRejectLoading[index] = false;
      update();
    }
  }

  Future<void> deleteUserInUsersScreen(User user, int index) async {
    try {
      final response = await usersService.deleteUser(user.id ?? '');

      if (response['success']) {
        Get.back();
        if (index >= 0 && index < acceptedUsers.length) {
          acceptedUsers.removeAt(index);
          MySnackBarsHelper.showMessage(
              'User ${user.firstName} ${user.lastName} removed successfully.');
        } else {
          MySnackBarsHelper.showError(
              'Something went wrong, please try again.');
        }
      } else {
        MySnackBarsHelper.showError('Something went wrong, please try again.');
      }
    } catch (e) {
      MySnackBarsHelper.showError('Something went wrong, please try again.');
    }
  }
}
