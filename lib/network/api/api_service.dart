import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum RequestMethod { GET, POST, PATCH, DELETE, PUT }

var apiBaseUrl = "https://cosmicbackend.invovision.io/api/";
var dio = Dio();

class ApiService {
  static Future<dynamic> apiRequest(
    String url, {
    required RequestMethod method,
    Map<String, dynamic>? body,
  }) async {
    var internet = await internetConnectivity();
    if (internet) {
      try {
        late Response response;
        dio.options.baseUrl = apiBaseUrl;
        // debugPrint(dio.options.headers['Authorization']);

        switch (method) {
          case RequestMethod.GET:
            response = await dio.get(url);
            break;
          case RequestMethod.POST:
            var formData = FormData();
            body?.forEach((key, value) {
              formData.fields.add(MapEntry(key, value));
            });
            response = await dio.post(url, data: formData);
            break;
          case RequestMethod.PATCH:
            response = await dio.patch(url, data: body);
            break;
          case RequestMethod.PUT:
            response = await dio.put(url, data: body);
            break;
          case RequestMethod.DELETE:
            response = await dio.delete(url);
            break;
        }

        debugPrint('Response Status Code: ${response.statusCode.toString()}');
        debugPrint('Response Data: ${response.data.toString()}');

        /*   if (response.data?['status'] == 'fail') throw (response.data['error']);*/

        // Return Response Data
        return response.data;
      } on DioError catch (e) {
        debugPrint(e.response?.statusCode.toString());

        if (e.response != null) {
          debugPrint(e.response?.data.toString());
          throw (e.response?.data?['error']);
        } else {
          debugPrint(e.message);
          throw ('${e.message}');
        }
      } catch (e) {
        print(e);
        throw ('$e');
      }
    } else {
      print('No Internet Connection');
      throw ('No Internet Connection');
    }
  }

  static Future<dynamic> apiRequestFieldsAndFiles(
    String url, {
    required RequestMethod method,
    required String fileKey,
    required List<File> files,
    required Map<String, dynamic> body,
  }) async {
    var internet = await internetConnectivity();
    if (internet) {
      try {
        late Response response;
        dio.options.baseUrl = apiBaseUrl;
        // Create FormData
        var formData = FormData();
        body.forEach((key, value) {
          formData.fields.add(MapEntry(key, value));
        });
        for (var file in files) {
          formData.files
              .add(MapEntry(fileKey, await MultipartFile.fromFile(file.path)));
        }

        // Send Request

        //  final fullUrl = 'http://192.168.0.117:5000/api/post/add';

        switch (method) {
          case RequestMethod.POST:
            response = await dio.post(url, data: formData);
            break;
          case RequestMethod.PUT:
            response = await dio.put(url, data: formData);
            break;
        }
        debugPrint(response.data.toString());
        // Return Response Data
        return response.data;
      } on DioError catch (e) {
        if (e.response != null) {
          debugPrint(e.response?.data.toString());
          throw (e.response?.data['error']);
        } else {
          debugPrint(e.message);
          throw (e.message);
        }
      }
    } else {
      throw 'No Internet Connection';
    }
  }

  static addAuthorizationHeader(String token) {
    dio.options.headers.addAll({
      'Authorization': token,
    });
  }

  static removeAuthorizationHeader() {
    dio.options.headers.removeWhere((key, value) => key == 'Authorization');
  }

  static Future<bool> internetConnectivity() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
    } on SocketException catch (_) {
      return false;
    }
    return false;
  }
}
