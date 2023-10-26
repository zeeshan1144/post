import 'dart:io';

import 'package:cosmic_post_office_main/network/api/api_service.dart';
import 'package:flutter/material.dart';

import '../../../helper/snackbar/snackbar_messages.dart';

class PostingProvider with ChangeNotifier {
  String? error;
  String? message;
  Future<void> uploadPost({
    required BuildContext context,
    required String uid,
    required String title,
    required String description,
    required String date,
    required File pickedImage,
  }) async {
    try {
      final response = await ApiService.apiRequestFieldsAndFiles(
        'post/add',
        method: RequestMethod.POST,
        fileKey: 'photo',
        files: [pickedImage],
        body: {
          'title': title,
          'description': description,
          'date': date,
          'uid': '$uid',
          'status': '1',
        },
      );
      // user['photo_path'] = response['data']['photo_path'];
      // await SPHelper.saveKeyInLocal('user', jsonEncode(user));
      message = response['message'];
      // message = response['error'];
      SMHelper.msgSnackBar(context, '${response['message']}');
      SMHelper.msgSnackBar(context, '${response['error']}');
      notifyListeners();
    } catch (e) {
      SMHelper.msgSnackBar(context, '${error}');

      rethrow;
    }
  }

  // dynamic data;

  postData(
    String userName,
    String description,
    String title,
    String date,
    String img,
    String uid,
  ) async {
    try {
      var map = Map<String, dynamic>();
      map['userName'] = userName;
      map['description'] = description;
      map['title'] = description;
      map['date'] = date;
      map['postImage'] = img;
      map['uid'] = uid;

      print(map);
      final response = await ApiService.apiRequest('post/add',
          method: RequestMethod.POST, body: map);

      print("Posting response result");
      print(response);
      message = response['message'];
      error = null;
      notifyListeners();
    } catch (e) {
      error = e.toString();
      message = null;
      notifyListeners();
    }
  }
}
