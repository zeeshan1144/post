import 'package:cosmic_post_office_main/helper/snackbar/snackbar_messages.dart';
import 'package:cosmic_post_office_main/network/api/api_service.dart';
import 'package:flutter/material.dart';

class NotificationProvider with ChangeNotifier {
  List<dynamic>? usersList;
  List<dynamic>? messageList;
  String? message;
  String? error;
  Future<void> fetchUsers(bool isLoad) async {
    try {
      if (isLoad == true) {
        usersList = null;
        message = null;
        error = null;
      }
      final response =
          await ApiService.apiRequest("/user", method: RequestMethod.GET);
      usersList = response['allUser'];
      notifyListeners();
    } catch (e) {
      error = e.toString();
      usersList = null;
      message = null;
      notifyListeners();
    }
  }

  //send and receive message
  Future<void> send(
    BuildContext ctx, {
    required var senderId,
    required var receiverId,
    required String message,
  }) async {
    try {
      final response = await ApiService.apiRequest(
        "message/add",
        method: RequestMethod.POST,
        body: {
          'senderId': senderId,
          'receiverId': receiverId,
          'message': message,
        },
      );
      message = response['message'];
      SMHelper.msgSnackBar(ctx, response['message']);
    } catch (e) {
      error = e.toString();
      SMHelper.msgSnackBar(ctx, error.toString());
    }
    notifyListeners();
  }

  receive(
      {required bool isLoad,
      required String senderId,
      required String receiverId}) async {
    try {
      if (isLoad == true) {
        messageList = null;
        message = null;
        error = null;
      }
      final response = await ApiService.apiRequest("message/get/",
          method: RequestMethod.POST,
          body: {'senderId': senderId, 'receiverId': receiverId});
      return response['Message'];
    } catch (e) {
      error = e.toString();
      messageList = null;
      message = null;
    }
    notifyListeners();
  }
}
