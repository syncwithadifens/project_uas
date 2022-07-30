import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:project_uas/model/food_model.dart';
import 'package:project_uas/model/user_model.dart';

class HttpService {
  final String apiUrl = 'http://foodmarket-backend.buildwithangga.id/api';
  Future<List<FoodModel>> getData() async {
    var result = await http.get(Uri.parse('$apiUrl/food'));
    if (result.statusCode == 200) {
      var parsedJson = jsonDecode(result.body);
      List<FoodModel> foods = (parsedJson['data']['data'] as Iterable)
          .map((e) => FoodModel.fromJson(e))
          .toList();
      return foods;
    } else {
      return [];
    }
  }

  Future<UserModel> login(String email, String password) async {
    var result = await http.post(Uri.parse('$apiUrl/login'), body: {
      'email': email,
      'password': password,
    });
    if (result.statusCode == 200) {
      return UserModel.fromJson(jsonDecode(result.body));
    } else {
      return null;
    }
  }

  Future<UserModel> register(String email, String password,
      String passwordConfirmation, String name, String address) async {
    var result = await http.post(Uri.parse('$apiUrl/register'), body: {
      'email': email,
      'password': password,
      'password_confirmation': passwordConfirmation,
      'name': name,
      'address': address,
    });
    if (result.statusCode == 200) {
      return UserModel.fromJson(jsonDecode(result.body));
    } else {
      return null;
    }
  }
}
