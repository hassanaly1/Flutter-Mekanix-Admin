import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mechanix_admin/data/api_endpoints.dart';

class AnalyticsService {
  Future<Map<String, dynamic>> getActivitiesAnalyticsData(
      {required String token}) async {
    String url =
        '${ApiEndPoints.baseUrl}${ApiEndPoints.dashboardActivitiesAnalyticsUrl}';
    try {
      final http.Response response = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        },
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        debugPrint('responseData: ${responseData["data"]}');
        return {'success': true};
      } else {
        return {'success': false};
      }
    } catch (e) {
      return {'success': false, 'error': e.toString()};
    }
  }

  Future<Map<String, dynamic>> getActivitiesCountData(
      {required String token}) async {
    String url =
        '${ApiEndPoints.baseUrl}${ApiEndPoints.dashboardActivitiesCountUrl}';
    try {
      final http.Response response = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        },
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        debugPrint('responseData: ${responseData["data"]}');
        return {'success': true};
      } else {
        return {'success': false};
      }
    } catch (e) {
      return {'success': false, 'error': e.toString()};
    }
  }
}
