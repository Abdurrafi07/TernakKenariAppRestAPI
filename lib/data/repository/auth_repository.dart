import 'dart:convert';

import 'package:canary_template/data/model/request/auth/login_request_model.dart';
import 'package:canary_template/data/model/response/auth_response_model.dart';
import 'package:canary_template/services/service_http_client.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthRepository {
  final ServiceHttpClient _serviceHttpClient;
  final secureStorage = FlutterSecureStorage();

  AuthRepository(this._serviceHttpClient);

    Future<Either<String, AuthResponseModel>> login(
    LoginRequestModel requestModel,
  ) async {
    try {
      final response = await _serviceHttpClient.post(
        'login',
        requestModel.toMap(),
      );
      final jsonResponse = json.decode(response.body);
      if (response.statusCode == 200) {
        final loginResponse = AuthResponseModel.fromMap(jsonResponse);
        await secureStorage.write(
          key: 'authToken',
          value: loginResponse.user!.token,
        );
        await secureStorage.write(
          key: 'userRole',
          value: loginResponse.user!.role,
        );
        return Right(loginResponse);
      } else {
        return Left(jsonResponse['message'] ?? 'Login failed');
      }
    } catch (e) {
      return left('An error occured while logging in.');
    }
  }
}