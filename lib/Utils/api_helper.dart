import 'dart:convert';
import 'package:http/http.dart' as http;

class APIHelper {
  APIHelper._();

  static final APIHelper apiHelper = APIHelper._();
  Map<String, dynamic> alldata = {};

  Future<void> fetchimage() async {
    String apiKey = '8c96f58319cc4b24bb035154231312';
    String api =
        'http://api.weatherapi.com/v1/current.json?key=$apiKey&q=rajkot&aqi=no';
    http.Response response = await http.get(Uri.parse(api));
    if (response.statusCode == 200) {
      String data = response.body;
      Map<String, dynamic> fetchmap = jsonDecode(data);
      alldata = fetchmap['location'];
    }
  }
}
