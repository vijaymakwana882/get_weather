import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../Models/weather_model.dart';

class WeatherProvider extends ChangeNotifier {
  Map<String, dynamic> location = {};
  Map<String, dynamic> current = {};
  Map<String, dynamic> forecast = {};
  List forecastday = [];
  List<WeatherModel> cities = [];
  Map<String, dynamic> day = {};
  List hour = [];
  List<WeatherModel> forecasthour = [];
  String city = "rajkot";

  Future<void> fetchimage() async {
    String apiKey = '8c96f58319cc4b24bb035154231312';
    String api =
        'http://api.weatherapi.com/v1/forecast.json?key=$apiKey&q=$city&days=10&aqi=no&alerts=no';
    http.Response response = await http.get(Uri.parse(api));
    if (response.statusCode == 200) {
      String data = response.body;
      Map<String, dynamic> fetchmap = jsonDecode(data);
      location = fetchmap['location'];
      current = fetchmap['current'];
      forecastday = fetchmap['forecast']['forecastday'];
      for (int i = 0; i < forecastday.length; i++) {
        hour.add(forecastday[i]['hour']);
      }
      day = forecastday[0]['day'];
    }
    notifyListeners();
  }

  void setcity() {
    cities.add(WeatherModel(
        name: location['name'],
        tempc: current['temp_c'],
        mintemp_c: forecastday[0]['day']['mintemp_c'],
        maxtemp_c: forecastday[0]['day']['maxtemp_c'],
        text: current['condition']['text']));
    notifyListeners();
  }

  void addcitie() {
    cities.add(WeatherModel(
        name: location['name'],
        tempc: current['temp_c'],
        mintemp_c: forecastday[0]['day']['mintemp_c'],
        maxtemp_c: forecastday[0]['day']['maxtemp_c'],
        text: current['condition']['text']));
    notifyListeners();
  }

  void removecity(int index) {
    cities.remove(cities[index]);
    notifyListeners();
  }

  void fetchcity(String val) {
    city = val;
    notifyListeners();
  }
}
