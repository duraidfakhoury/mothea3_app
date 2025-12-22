import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:mothea3_app/core/constants/api_urls.dart';
import 'package:mothea3_app/core/network/network_helper.dart';
import 'package:mothea3_app/core/services/cache_service.dart';
// import 'package:mothea3_app/core/network/network_helper.dart';
import 'package:mothea3_app/modules/auth/data/data_source/auth_data_source.dart';
import 'package:mothea3_app/modules/auth/data/model/profile_model.dart';
import 'package:mothea3_app/modules/auth/data/model/login_response_model.dart';
import 'package:mothea3_app/modules/auth/data/model/register_response_model.dart';
import 'package:mothea3_app/modules/auth/domain/parameters/login_parameters.dart';
import 'package:mothea3_app/modules/auth/domain/parameters/register_parameters.dart';

class AuthDataSourceImpl extends AuthDataSource {
  @override
  Future<LoginResponseModel> login(LoginParameters parameters) async {
    NetworkResponse response = await NetworkHelper().post(
      ApisUrls().login,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      data: parameters.toJson(),
    );
    await CacheService().setToken(response.data['token']);
    final loginResponse = LoginResponseModel.fromJson(response.data);
    return (loginResponse);
  }

  @override
  Future<RegisterResponseModel> register(RegisterParameters parameters) async {
    NetworkResponse response = await NetworkHelper().post(
      ApisUrls().register,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      data: parameters.toJson(),
    );
    await CacheService().setToken(response.data['token']);
    final ragisterResponse = RegisterResponseModel.fromJson(response.data);
    return (ragisterResponse);
  }

  @override
  Future<ProfileModel> getUser() async {
    // Load the local JSON file
    final String jsonString = await rootBundle.loadString(
      'assets/local_jsons/profile.json',
    );

    // Decode the JSON string
    final Map<String, dynamic> jsonMap = json.decode(jsonString);

    // Map each JSON object to a model
    final ProfileModel profile = ProfileModel.fromJson(jsonMap);

    return profile;
  }
}
