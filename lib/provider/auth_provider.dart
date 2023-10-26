import 'dart:convert';
import 'dart:io';
import 'package:cosmic_post_office_main/helper/prefrences/shared_pref.dart';
import 'package:cosmic_post_office_main/helper/snackbar/snackbar_messages.dart';
import 'package:cosmic_post_office_main/network/api/api_service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AuthProvider with ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  final txtEmail = TextEditingController();
  final txtPassword = TextEditingController();
  String? error;
  String? message;
  String? token;
  dynamic? user;
  bool isAuthenticated = false;
  bool isLogging = false;
  File? profile;
  final pickProfile = ImagePicker();

  //login first
  Future<void> login(
    BuildContext context, {
    required String email,
    required String password,
  }) async {
    try {
      if (txtEmail.text != null && txtPassword != null) {
        print("object in");
        final response = await ApiService.apiRequest('user/login',
            method: RequestMethod.POST,
            body: {
              'email': email,
              'password': password,
            });
        print(response);
        SMHelper.msgSnackBar(context, response['message']);
        message = response['message'];
        await setAuth(response);
      }
    } catch (e) {
      error = e.toString();

      SMHelper.msgSnackBar(context, e.toString());
      isLogging = false;
    }
    notifyListeners();
  }
//change password

  Future<void> changePassword(
    BuildContext context, {
    required String password,
    required String id,
  }) async {
    try {
      if (txtEmail.text != null && txtPassword != null) {
        final response = await ApiService.apiRequest('user/changepassword',
            method: RequestMethod.PUT,
            body: {
              'id': id,
              'password': password,
            });
        SMHelper.msgSnackBar(context, response['message']);
        message = response['message'];
        SMHelper.msgSnackBar(context, "${response}");
        await setAuth(response);

        notifyListeners();
      }
    } catch (e) {
      error = e.toString();
      SMHelper.msgSnackBar(context, "${error}");
      isLogging = false;
      notifyListeners();
    }
    notifyListeners();
  }

//----------load use
  Future<void> loadUser() async {
    try {
      token = await SPHelper.getKeyFromLocal('token');
      // debugPrint(token);
      if (token == '') return;
      await ApiService.addAuthorizationHeader(token as String);
      final u = await SPHelper.getKeyFromLocal('user');
      user = jsonDecode(u);
      isAuthenticated = true;
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  //set Auth
  Future<void> setAuth(dynamic response) async {
    // Add Authorization to all requests headers
    final t = 'Bearer ${response['token'] as String}';
    await ApiService.addAuthorizationHeader(t);
    // Add Token from Local Storage
    await SPHelper.saveKeyInLocal('token', t);
    await SPHelper.saveKeyInLocal('user', jsonEncode(response['user']));

    // Change State
    token = t;
    user = response['user'];
    isAuthenticated = true;
    notifyListeners();
  }

  Future<void> logout(BuildContext context) async {
    await _resetAuth();
    Navigator.pushNamedAndRemoveUntil(context, "/LoginView", (route) => false);
  }

  Future<void> _resetAuth() async {
    // Remove Authorization from all requests headers
    await ApiService.removeAuthorizationHeader();

    // Remove Token from Local Storage
    await SPHelper.removeKeyFromLocal('token');
    await SPHelper.removeKeyFromLocal('user');

    // Reset State
    isAuthenticated = false;
    user = null;
    token = null;

// Notify everywhere where the provider is used
    notifyListeners();
  }

  Future<void> getProfile(BuildContext context, String id) async {
    final imageProfile =
        await pickProfile.pickImage(source: ImageSource.gallery);
    if (imageProfile != null) {
      profile = File(imageProfile.path);
      await updateDpPicture(context, pickImage: profile!, id: id);
      notifyListeners();
    }
  }

  Future<void> updateDpPicture(BuildContext context,
      {required File pickImage, String? id}) async {
    try {
      final response = await ApiService.apiRequestFieldsAndFiles(
        'user/update/$id',
        fileKey: 'photo',
        files: [pickImage],
        body: {'id': id},
        method: RequestMethod.PUT,
      );
      user['userImage'] = response['user']['userImage'];
      await SPHelper.saveKeyInLocal('user', jsonEncode(user));
      SMHelper.msgSnackBar(context, response['message']);
      profile = null;
      notifyListeners();
    } catch (e) {
      SMHelper.msgSnackBar(context, '${e.toString()}');
    }
    notifyListeners();
  }
}
