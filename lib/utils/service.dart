import 'dart:convert';

import 'package:api_cache_manager/api_cache_manager.dart';
import 'package:api_cache_manager/models/cache_db_model.dart';
import 'package:ecs_attendance/models/register.dart';
import 'package:flutter/material.dart';

class SharedService {
  static Future<bool> isLoggedIn() async {
    var isCacheKeyExist =
        await APICacheManager().isAPICacheKeyExist("login_details");

    return isCacheKeyExist;
  }

   static Future<Register?> loginDetails() async {
    var isCacheKeyExist =
        await APICacheManager().isAPICacheKeyExist("login_details");

    if (isCacheKeyExist) {
      var cacheData = await APICacheManager().getCacheData("login_details");

      return loginResponseJson(cacheData.syncData);
    }
    return null;
  }

  static Future<void> setLoginDetails(
    Register student,
  ) async {
    APICacheDBModel cacheModel = APICacheDBModel(
      key: "login_details",
      syncData: jsonEncode(student.toJson()),
    );

    await APICacheManager().addCacheData(cacheModel);
  }

  static Future<void> logout(BuildContext context, [bool mounted = true]) async {
    await APICacheManager().deleteCache("login_details");
     if (!mounted) return;
    Navigator.pushNamedAndRemoveUntil(
      context,
      '/login',
      (route) => false,
    );
  }
}
