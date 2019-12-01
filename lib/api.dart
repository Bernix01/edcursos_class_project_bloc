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

  bool get _authorized => this._token != null;
  String _token;

  authorize(String token) {
    this._token = token;
  }

  static const String BASE_URL = "https://edcursos-flutter.herokuapp.com";

  Future<StreamedResponse> send(BaseRequest request) {
    request.headers['Content-Type'] = "application/json";
    if (this._authorized) {
      print(this._token);
      request.headers['Authorization'] = "Bearer ${this._token}";
    }
    return _inner.send(request);
  }
}
