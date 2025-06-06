import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:canary_template/data/model/request/admin/admin_profile_request.dart';
import 'package:canary_template/data/model/response/admin_profile_response_model.dart';
import 'package:canary_template/services/service_http_client.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:nativewrappers/_internal/vm/lib/developer.dart';

class ProfileAdminRepository {
  final ServiceHttpClient _serviceHttpClient;
  final secureStorage = FlutterSecureStorage();

  ProfileAdminRepository(this._serviceHttpClient);

  Future<Either<String, AdminProfileResponseModel>> addProfile(
    AdminProfileRequestModel requestModel,
  ) async {
    try {
      final response = await _serviceHttpClient.postWithToken(
        'admin/profile',
        requestModel.toMap(),
      );
      final jsonResponse = json.decode(response.body);
      if (response.statusCode == 201) {
        final profileResponse = AdminProfileResponseModel.fromMap(jsonResponse);
        log("Add Admin Profile successful: ${profileResponse.message}");
        return Right(profileResponse);
      } else {
        log("Add Admin Profile failed: ${jsonResponse['message']}");
        return Left(jsonResponse['message'] ?? "Create Profile failed");
      }
    } catch (e) {
      log("Error in adding profile: $e");
      return Left("An error occurred while adding profile: $e");
    }
  }
}
