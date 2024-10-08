class ApiEndPoints {
  // static String baseUrl = 'https://mechanix-api-production.up.railway.app';
  // static String baseUrl = 'https://mechanix-api.vercel.app';
  static String baseUrl = 'https://mechanixapi-production.up.railway.app';

  //Authentications
  static String loginUserUrl = '/api/auth/adminlogin';
  static String sendOtpUrl = '/api/auth/send-reset-password-email';
  static String verifyOtpUrl = '/api/auth/verify-reset-otp';
  static String changePasswordUrl = '/api/auth/changepassword';
  static String updateProfileUrl = '/api/auth/editprofile';
  static String updateProfilePictureUrl = '/api/auth/editprofilefile';

  //UsersManagement
  static String getAllUsersUrl = '/api/user/getallusers';
  static String approveUserUrl = '/api/user/approveduseraccount';
  static String deleteUserUrl = '/api/user/deleteUserAccount';

  //Analytics
  static String dashboardActivitiesAnalyticsUrl =
      '/api/analytics/dashboard-activities-analytics';
  static String dashboardActivitiesCountUrl =
      '/api/analytics/dashboard-activties-count';
}
