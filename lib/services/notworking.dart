import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  final String url;
  final Map<String, String> headers;

  NetworkHelper(this.url, this.headers);

  Future getData() async {
    http.Response response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      String data = response.body;
      return jsonDecode(data);
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }
}
