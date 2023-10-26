import 'package:cosmic_post_office_main/widgets/background_widget.dart';
import 'package:cosmic_post_office_main/widgets/textformfiled_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'dart:math' as math;

class SignupView extends StatelessWidget {
  SignupView({Key? key}) : super(key: key);
  static const routeName = "/SignupView";
  TextEditingController txtUsername = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtDOB = TextEditingController();
  TextEditingController txtPass = TextEditingController();
  TextEditingController txtConPass = TextEditingController();
  TextEditingController txtCoord = TextEditingController();
  @override
  Widget build(BuildContext context) {
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
                      'Create Account',
                      style: TextStyle(color: Colors.grey, fontSize: 30),
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
                      child: CircleAvatar(
                        radius: 70,
                        backgroundColor: Colors.black,
                      ),
                    ),
                    SizedBox(
                      height: 30,
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
                      hint: "",
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
                      hint: "",
                      maxLines: 1,
                      validate: (value) {},
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      "Password:",
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextFormFiledWidget(
                      controller: txtPass,
                      textInputAction: TextInputAction.next,
                      hint: "",
                      maxLines: 1,
                      validate: (value) {},
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      "Confirm Password:",
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextFormFiledWidget(
                      controller: txtConPass,
                      textInputAction: TextInputAction.next,
                      hint: "",
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
                      textInputAction: TextInputAction.done,
                      hint: "",
                      maxLines: 1,
                      validate: (value) {},
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Center(
                      child: CupertinoButton(
                        child: Text(
                          "Blast Off!",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic),
                        ),
                        onPressed: () {},
                        color: Colors.grey.shade200,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0, right: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Term of use",
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            "Privacy Policy",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
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
