import 'package:cosmic_post_office_main/constant/constant_view.dart';
import 'package:cosmic_post_office_main/provider/auth_provider.dart';
import 'package:cosmic_post_office_main/screens/nav/provider/nav_provider.dart';
import 'package:cosmic_post_office_main/widgets/background_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:math' as math;

import 'package:provider/provider.dart';

class ShowOrbitsPost extends StatefulWidget {
  const ShowOrbitsPost({Key? key}) : super(key: key);
  static const routeName = "/ShowOrbitsPost";
  @override
  State<ShowOrbitsPost> createState() => _ShowOrbitsPostState();
}

class _ShowOrbitsPostState extends State<ShowOrbitsPost> {
  @override
  Widget build(BuildContext context) {
    final navProvider = Provider.of<NavProvider>(context);
    final user = Provider.of<AuthProvider>(context).user;

    return Background(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                  GestureDetector(
                    onTap: () {
                      navProvider.changeIndex(5);
                    },
                    child: user['userImage'] != null
                        ? CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.black,
                            backgroundImage: NetworkImage(
                                "http://192.168.43.133:5000/public/userimage/${user['userImage']}"),
                          )
                        : CircleAvatar(
                            radius: 30,
                          ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.black,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Orbits',
                  style: TextStyle(color: Colors.grey, fontSize: 25),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Expanded(
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: 1,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        color: Constants.textFiledColors.withOpacity(0.5),
                        padding: const EdgeInsets.all(5.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Post Titile",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "08/02/2022",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Image(
                              image: AssetImage(
                                  "assets/images/testing_broadcast.png"),
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Text(
                              "I don’t know what this means or what anything means really. It’s just a test, that’s all.",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            ),
          ],
        )),
      ),
    );
  }
}
