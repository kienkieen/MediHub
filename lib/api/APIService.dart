import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:medihub_app/api/APIQRequest.dart';

class APIService {
  static const String _baseUrl = 'https://api.vietqr.io/v2/generate';

  Future<APIResponse> generateQRCode(APIRequest request) async {
    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(request.toJson()),
    );

    if (response.statusCode == 200) {
      return APIResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to generate QR Code: ${response.body}');
    }
  }
}
