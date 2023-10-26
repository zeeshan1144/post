import 'package:cosmic_post_office_main/helper/snackbar/snackbar_messages.dart';
import 'package:cosmic_post_office_main/helper/validator/validation.dart';
import 'package:cosmic_post_office_main/provider/auth_provider.dart';
import 'package:cosmic_post_office_main/screens/nav/view/master_page.dart';
import 'package:cosmic_post_office_main/screens/signup/view/signup_view.dart';
import 'package:cosmic_post_office_main/widgets/background_widget.dart';
import 'package:cosmic_post_office_main/widgets/textformfiled_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'dart:math' as math;

import 'package:provider/provider.dart';

class LoginView extends StatefulWidget {
  LoginView({Key? key}) : super(key: key);
  static const routeName = "/LoginView";

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  bool isloading = false;
  @override
  Widget build(BuildContext context) {
    final loginAuth = Provider.of<AuthProvider>(context, listen: false);
    return Background(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Center(
                  child: Transform.rotate(
                    angle: -math.pi / 9.5,
                    child: Text(
                      'Send it!',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 30),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 80,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 15),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Image(
                          image: AssetImage(
                            "assets/images/cosmic_post.png",
                          ),
                          width: 250,
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        "Email:",
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      TextFormFiledWidget(
                        controller: loginAuth.txtEmail,
                        textInputAction: TextInputAction.next,
                        hint: "Email",
                        maxLines: 1,
                        validate: (value) {
                          return FormValidator.checkEmail(value);
                        },
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
                        controller: loginAuth.txtPassword,
                        textInputAction: TextInputAction.done,
                        hint: "Password",
                        maxLines: 1,
                        validate: (value) {
                          return FormValidator.checkLength(
                              value, "Password", 6);
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              isloading == false
                  ? InkWell(
                      onTap: () async {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            isloading = true;
                          });
                          await loginAuth.login(context,
                              email: loginAuth.txtEmail.text,
                              password: loginAuth.txtPassword.text);
                          setState(() {
                            isloading = false;
                          });
                        }
                      },
                      child: Center(
                        child: Container(
                          width: 150,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: loginAuth.isLogging == true
                                ? Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Let's Go",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                      Image(
                                          image: AssetImage(
                                              "assets/images/rocket.png"))
                                    ],
                                  ),
                          ),
                        ),
                      ),
                    )
                  : CircularProgressIndicator(),
              SizedBox(
                height: 20,
              ),
              Center(
                  child: TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignupView()));
                      },
                      child: Text(
                        "Signup",
                        style: TextStyle(color: Colors.white),
                      ))),
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
        )),
      ),
    );
  }
}
