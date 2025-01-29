import 'dart:developer';

import 'package:app/core/utils/constants.dart';
import 'package:app/core/utils/navigation_service.dart';
import 'package:app/core/utils/token_preference.dart';
import 'package:app/pages/auth/view/login_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DioClient {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: Constants.baseUrl,
      connectTimeout: const Duration(milliseconds: 5000),
      receiveTimeout: const Duration(seconds: 10),
    ),
  )..interceptors.add(CustomInterceptors());
  Dio getInstance() {
    return _dio;
  }
}

class CustomInterceptors extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await TokenPreference.getToken();
    if (token?.isNotEmpty ?? false) {
      options.headers["Authorization"] = "Bearer $token";
    }
    super.onRequest(options, handler);
  }

  @override
  Future<void> onError(
      DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 403) {
      await TokenPreference.setToken("");

      final context = NavigationService.navigatorKey.currentContext;
      if (context != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      }
    }

    log(
      'ERROR[${err.response?.statusCode}] - ${err.response?.statusMessage} | PATH: ${err.requestOptions.path} | DATA: ${err.response?.data}',
      error: err,
    );

    super.onError(err, handler);
  }
}
