import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:mothea3_app/core/enums/auth_status.dart';
// import 'package:mothea3_app/core/network/network_helper.dart';
import 'package:mothea3_app/modules/auth/data/data_source/auth_data_source.dart';
import 'package:mothea3_app/modules/auth/data/model/profile_model.dart';
import 'package:mothea3_app/modules/auth/domain/parameters/login_parameters.dart';
import 'package:mothea3_app/modules/auth/domain/parameters/register_parameters.dart';

class AuthDataSourceImpl extends AuthDataSource {
  @override
  Future<AuthStatus> login(LoginParameters parameters) async {
    // NetworkResponse response = await NetworkHelper().post(
    //   ""
    // );
    return AuthStatus.authenticated;
  }

  @override
  Future<AuthStatus> register(RegisterParameters parameters) async {
    return AuthStatus.authenticated;
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
