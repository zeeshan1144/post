import 'package:cosmic_post_office_main/provider/auth_provider.dart';
import 'package:cosmic_post_office_main/screens/nav/provider/nav_provider.dart';
import 'package:cosmic_post_office_main/screens/notification/provider/notificaion_provider.dart';
import 'package:cosmic_post_office_main/screens/notification/view/show_notification_view.dart';
import 'package:cosmic_post_office_main/widgets/background_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;

import '../../../constant/constant_view.dart';

class NotificationView extends StatefulWidget {
  const NotificationView({Key? key}) : super(key: key);
  static const routeName = "/NotificationView";

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  bool isLoading = false;
  @override
  void initState() {
    final data =
        Provider.of<NotificationProvider>(context, listen: false).usersList;
    if (data == null) {
      fetchData(true);
    }
    fetchData(true);
    super.initState();
  }

  fetchData(bool isFetch) async {
    setState(() => isLoading = true);
    await Provider.of<NotificationProvider>(context, listen: false)
        .fetchUsers(isFetch);
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    final navProvider = Provider.of<NavProvider>(context);
    final user = Provider.of<AuthProvider>(context).user;
    final notiPr = Provider.of<NotificationProvider>(context, listen: true);
    return Background(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
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
                  GestureDetector(
                    onTap: () {
                      navProvider.changeIndex(5);
                    },
                    child: user['userImage'] != null
                        ? CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.black,
                            backgroundImage: NetworkImage(
                                "http://192.168.0.105:5000/public/userimage/${user['userImage']}"),
                          )
                        : CircleAvatar(
                            radius: 30,
                          ),
                  ),
                ],
              ),
            ),
            Center(
              child: Transform.rotate(
                angle: -math.pi / 9.5,
                child: Text(
                  'Notification',
                  style: TextStyle(color: Colors.grey, fontSize: 25),
                ),
              ),
            ),
            notiPr.usersList == null
                ? isLoading == true
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Text(
                        "Data not found",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white),
                      )
                : Expanded(
                    child: ListView.builder(
                      itemCount: notiPr.usersList!.length,
                      itemBuilder: (context, index) {
                        final items = notiPr.usersList![index];
                        return ListTile(
                          onTap: () {
                            /* Navigator.pushNamed(
                              context,
                              '/ShowNotificationView',
                              arguments: {'receiverId': items['_id']},
                            );*/
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ShowNotificationView(
                                          receiverId: items['_id'],
                                          senderId: user['_id'],
                                        )));
                          },
                          title: Stack(
                            children: [
                              Column(
                                children: [
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 15.0),
                                    child: Container(
                                      height: 70,
                                      width: double.infinity,
                                      color: Constants.textFiledColors
                                          .withOpacity(0.5),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          GestureDetector(
                                            onTap: () {},
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Icon(
                                                  Icons
                                                      .expand_circle_down_outlined,
                                                  color: Colors.white,
                                                  size: 30,
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Text(
                                            "${items['userName']}",
                                            style:
                                                TextStyle(color: Colors.white),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                ],
                              ),
                              Positioned(
                                  left: 0,
                                  child: CircleAvatar(
                                    radius: 50,
                                    backgroundImage: NetworkImage(
                                        "http://192.168.0.105:5000/public/userimage/${items['userImage']}"),
                                  ))
                            ],
                          ),
                        );
                      },
                    ),
                  ),
          ],
        )),
      ),
    );
  }
}
