import 'package:cosmic_post_office_main/constant/constant_view.dart';
import 'package:cosmic_post_office_main/helper/validator/validation.dart';
import 'package:cosmic_post_office_main/provider/auth_provider.dart';
import 'package:cosmic_post_office_main/screens/nav/provider/nav_provider.dart';
import 'package:cosmic_post_office_main/widgets/background_widget.dart';
import 'package:cosmic_post_office_main/widgets/textformfiled_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'dart:math' as math;

import 'package:provider/provider.dart';

import '../../../helper/snackbar/snackbar_messages.dart';

class ChangePasswordView extends StatefulWidget {
  ChangePasswordView({Key? key}) : super(key: key);
  static const routeName = "/ChangePasswordView";

  @override
  State<ChangePasswordView> createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends State<ChangePasswordView> {
  TextEditingController txtOld = TextEditingController();

  TextEditingController txtNew = TextEditingController();

  TextEditingController txtCon = TextEditingController();

  final formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final navProvider = Provider.of<NavProvider>(context);
    // final user = Provider.of<AuthProvider>(context).user;
    final auth = Provider.of<AuthProvider>(context, listen: false);
    return Background(
      child: ProgressHUD(
        child: Builder(builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Change Password"),
              backgroundColor: Constants.textFiledColors.withOpacity(0.5),
            ),
            backgroundColor: Colors.transparent,
            body: SafeArea(
                child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 12.0, left: 12.0, right: 12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image(
                          image: AssetImage(
                            "assets/images/cosmic_post.png",
                          ),
                          width: 180,
                        ),
                        /* GestureDetector(
                        onTap: () {
                          controller.changePage(5);
                        },
                        child: CircleAvatar(
                          radius: 30,
                        ),
                      ),*/
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Center(
                      child: Transform.rotate(
                        angle: -math.pi / 9.5,
                        child: Text(
                          'Chnage Password',
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
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: auth.user['userImage'] != null
                                ? CircleAvatar(
                                    radius: 70,
                                    backgroundColor: Colors.black,
                                    backgroundImage: NetworkImage(
                                        "http://192.168.0.117:5000/public/userimage/${auth.user['userImage']}"),
                                  )
                                : CircleAvatar(
                                    radius: 70,
                                    backgroundColor: Colors.black,
                                  ),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            "New Password:",
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          TextFormFiledWidget(
                            controller: txtNew,
                            textInputAction: TextInputAction.next,
                            hint: "",
                            maxLines: 1,
                            validate: (value) {
                              return FormValidator.checkLength(
                                  value, "Password", 6);
                            },
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
                            controller: txtCon,
                            textInputAction: TextInputAction.done,
                            hint: "",
                            maxLines: 1,
                            validate: (value) {
                              return FormValidator.confirmPassword(
                                  value, txtNew.text, "Password", 6);
                            },
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Center(
                            child: CupertinoButton(
                              child: Text(
                                "Submit",
                                style: TextStyle(color: Colors.black),
                              ),
                              onPressed: () async {
                                if (formKey.currentState!.validate()) {
                                  final progress = ProgressHUD.of(context);

                                  setState(() {
                                    progress!.showWithText('Uploading...');
                                    isLoading = true;
                                  });
                                  await auth.changePassword(
                                    context,
                                    id: auth.user['_id'],
                                    password: txtCon.text,
                                  );
                                  setState(() {
                                    txtNew.clear();
                                    txtCon.clear();

                                    progress!.dismiss();
                                    isLoading = false;
                                  });
                                }
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
                    ),
                  )
                ],
              ),
            )),
          );
        }),
      ),
    );
  }
}
