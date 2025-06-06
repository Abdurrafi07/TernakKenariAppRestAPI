import 'dart:convert';
import 'dart:developer';
import 'package:canary_template/data/model/request/admin/posting_jual_request_model.dart';
import 'package:canary_template/data/model/response/burung_semua_tersedia_model.dart';
import 'package:canary_template/services/service_http_client.dart';
import 'package:dartz/dartz.dart';

class PostingRepository {
  final ServiceHttpClient _serviceHttpClient;
  PostingRepository(this._serviceHttpClient);

  Future<Either<String, BurungSemuaTersediabyIdModel>> addPostBurung(
    PostingJualRequestModel requestModel,
  ) async {
    try {
      final response = await _serviceHttpClient.post(
        'admin/posting-jual',
        requestModel.toMap(),
      );
      final jsonResponse = json.decode(response.body);
      if (response.statusCode == 201) {
        final profileResponse = BurungSemuaTersediabyIdModel.fromJson(
          jsonResponse,
        );
        log("Add Burung successful: ${profileResponse.message}");
        return Right(profileResponse);
      } else {
        log("Add Burung failed: ${jsonResponse['message']}");
        return Left(jsonResponse['message'] ?? 'Add Burunng failed');
      }
    } catch (e) {
      log("Error in Add burung: $e");
      return Left("An error occurred while post burung: $e");
    }
  }
}
