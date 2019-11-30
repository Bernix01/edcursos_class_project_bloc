import 'package:http/http.dart';

class ApiClient extends BaseClient {
  // Singleton
  Client _inner;
  static final ApiClient _singleton = ApiClient._internal();
  static ApiClient get instance => _singleton;
  ApiClient._internal() {
    _inner = Client();
  }
  // End Singleton

  static const String BASE_URL = "https://c227548d.ngrok.io";

  Future<StreamedResponse> send(BaseRequest request) {
    request.headers['Content-Type'] = "application/json";
    return _inner.send(request);
  }
}
