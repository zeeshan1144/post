import 'dart:io';

import 'package:cosmic_post_office_main/provider/auth_provider.dart';
import 'package:cosmic_post_office_main/screens/nav/provider/nav_provider.dart';
import 'package:cosmic_post_office_main/screens/setting/view/change_password_view.dart';
import 'package:cosmic_post_office_main/widgets/background_widget.dart';
import 'package:cosmic_post_office_main/widgets/textformfiled_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:provider/provider.dart';

class SettingView extends StatelessWidget {
  SettingView({Key? key}) : super(key: key);
  static const routeName = "/SettingView";
  TextEditingController txtUsername = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtDOB = TextEditingController();
  TextEditingController txtCoord = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final navProvider = Provider.of<NavProvider>(context);
    final auth = Provider.of<AuthProvider>(context);
    final user = Provider.of<AuthProvider>(context).user;
    txtUsername.text = user['userName'];
    txtEmail.text = user['email'];
    txtCoord.text = user['coordinate'];
    String id = user['_id'];

    return Background(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.only(top: 12.0, left: 12.0, right: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image(
                      image: AssetImage(
                        "assets/images/cosmic_post.png",
                      ),
                      width: 180,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Center(
                  child: Transform.rotate(
                    angle: -math.pi / 9.5,
                    child: Text(
                      'Setting',
                      style: TextStyle(color: Colors.grey, fontSize: 25),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Stack(
                        children: [
                          user['userImage'] != null
                              ? CircleAvatar(
                                  radius: 70,
                                  backgroundColor: Colors.black,
                                  backgroundImage: NetworkImage(
                                      "http://192.168.0.117:5000/public/userimage/${user['userImage']}"),
                                )
                              : auth.profile != null
                                  ? CircleAvatar(
                                      radius: 70,
                                      backgroundColor: Colors.black,
                                      backgroundImage:
                                          FileImage(File(auth.profile!.path)),
                                    )
                                  : CircleAvatar(
                                      radius: 70,
                                      backgroundColor: Colors.black,
                                    ),
                          Positioned(
                            bottom: 5,
                            right: 10,
                            child: IconButton(
                              onPressed: () {
                                auth.getProfile(context, id);
                              },
                              icon: Icon(
                                Icons.photo_camera,
                                color: Colors.white,
                                size: 35,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Text(
                      "Username:",
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextFormFiledWidget(
                      controller: txtUsername,
                      textInputAction: TextInputAction.next,
                      hint: "UserName",
                      maxLines: 1,
                      validate: (value) {},
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      "Email:",
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextFormFiledWidget(
                      controller: txtEmail,
                      textInputAction: TextInputAction.next,
                      hint: "Email@gmailcom",
                      maxLines: 1,
                      validate: (value) {},
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      "DOB:",
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextFormFiledWidget(
                      controller: txtDOB,
                      textInputAction: TextInputAction.next,
                      hint: "07/24/1998",
                      maxLines: 1,
                      validate: (value) {},
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      "Coordinates:",
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextFormFiledWidget(
                      controller: txtCoord,
                      textInputAction: TextInputAction.next,
                      hint: "Coordinates",
                      maxLines: 1,
                      validate: (value) {},
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Center(
                      child: CupertinoButton(
                        child: Text(
                          "Change Password",
                          style: TextStyle(color: Colors.black),
                        ),
                        onPressed: () {
                          //  navProvider.changeIndex(6);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => ChangePasswordView()));
                        },
                        color: Colors.grey.shade200,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: CupertinoButton(
                        child: Text(
                          "Logout",
                          style: TextStyle(color: Colors.black),
                        ),
                        onPressed: () async {
                          await auth.logout(context);
                        },
                        color: Colors.grey.shade200,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Text(
                        "© 2022 Cosmic Post Office",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              )
            ],
          ),
        )),
      ),
    );
  }
}
