import 'dart:convert';
import 'package:core_encode/core_encode.dart';
import 'package:http/http.dart';
import 'package:injectable/injectable.dart';

abstract class HttpServiceBase {
  final Client http;

  HttpServiceBase({required this.http});

  Future<Map> get(String url);
  Future<Map> post(String url, Entity data);
}

@Injectable(as: HttpServiceBase)
class HttpService extends HttpServiceBase {
  HttpService({required super.http});

  @override
  Future<Map> get(String url) async {
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Error en la solicitud GET: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Excepción durante la solicitud GET: $e');
    }
  }

  @override
  Future<Map> post(String url, Entity data) async {
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: json.encode(data.toJson()),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return json.decode(response.body);
      } else {
        throw Exception('Error en la solicitud POST: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Excepción durante la solicitud POST: $e');
    }
  }
}
