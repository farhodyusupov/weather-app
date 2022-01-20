// TODO Implement this library
import "package:dio/dio.dart";
import 'package:weather_app/models/current.dart';


class CurrentDio{


   Future<Current> getCurrentData(String cityName) async {
    // Perform GET request to the endpoint "/users/<id>"
    Dio dio = Dio();
    Response currentData = await dio.get("http://api.weatherstack.com/current?access_key=c1c6693c6c035f178409278e613402b4&query="+cityName);

    // Prints the raw data returned by the server

    // Parsing the raw JSON data to the User class
    Current current = Current.fromMap(currentData.data);

    return current;
  }


}