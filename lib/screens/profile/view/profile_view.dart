import 'package:cosmic_post_office_main/constant/constant_view.dart';
import 'package:cosmic_post_office_main/provider/auth_provider.dart';
import 'package:cosmic_post_office_main/widgets/background_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;
import '../../../widgets/textformfiled_widget.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);
  static const routeName = "/ProfileView";
  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  TextEditingController txtUsername = TextEditingController();
  TextEditingController txtMission = TextEditingController();
  TextEditingController txtMessage = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthProvider>(context).user;
    txtUsername.text = user['userName'];
    return Background(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
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
              Center(
                child: Transform.rotate(
                  angle: -math.pi / 9.5,
                  child: Text(
                    'Profile',
                    style: TextStyle(color: Colors.grey, fontSize: 25),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: user['userImage'] != null
                          ? CircleAvatar(
                              radius: 50,
                              backgroundColor: Colors.black,
                              backgroundImage: NetworkImage(
                                  "http://192.168.0.117:5000/public/userimage/${user['userImage']}"),
                            )
                          : CircleAvatar(
                              radius: 50,
                            ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Text(
                      "UserName:",
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      width: 170,
                      height: 50,
                      child: TextFormFiledWidget(
                        controller: txtUsername,
                        textInputAction: TextInputAction.next,
                        hint: "UserName",
                        maxLines: 1,
                        validate: (value) {},
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      "Mission:",
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextFormFiledWidget(
                      controller: txtMission,
                      textInputAction: TextInputAction.next,
                      hint: "",
                      maxLines: 5,
                      validate: (value) {},
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      "Message:",
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextFormFiledWidget(
                      controller: txtMessage,
                      textInputAction: TextInputAction.done,
                      hint: "",
                      maxLines: 5,
                      validate: (value) {},
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
