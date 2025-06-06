import 'package:canary_template/services/service_http_client.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ProfileAdminRepository {
  final ServiceHttpClient _serviceHttpClient;
  final secureStorage = FlutterSecureStorage();

  ProfileAdminRepository(this._serviceHttpClient);
}