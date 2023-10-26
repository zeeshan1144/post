import 'package:cosmic_post_office_main/screens/broadcast/view/broadcast_view.dart';
import 'package:cosmic_post_office_main/screens/nav/provider/nav_provider.dart';
import 'package:cosmic_post_office_main/screens/notification/view/notification_view.dart';
import 'package:cosmic_post_office_main/screens/orbits/view/orbits_view.dart';
import 'package:cosmic_post_office_main/screens/posting/view/posting_view.dart';
import 'package:cosmic_post_office_main/screens/profile/view/profile_view.dart';
import 'package:cosmic_post_office_main/screens/setting/view/setting_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../widgets/nav_card_widget.dart';

class MasterPage extends StatelessWidget {
  const MasterPage({Key? key}) : super(key: key);
  static const routeName = "/masterPage";
  @override
  Widget build(BuildContext context) {
    final navProvider = Provider.of<NavProvider>(context);
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/bgimg.png"), fit: BoxFit.fill)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: navProvider.PagesAll[navProvider.index],
        bottomNavigationBar: Padding(
          padding: EdgeInsets.all(8),
          child: Material(
            elevation: 10,
            // borderRadius: BorderRadius.circular(20),
            color: Colors.black.withOpacity(0.5),
            child: Container(
              height: 70,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 2, color: Colors.white),
                  top: BorderSide(width: 2, color: Colors.white),
                  right: BorderSide(width: 2, color: Colors.white),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        navProvider.changeIndex(0);
                      },
                      child: navCardWidget(0, navProvider.index, "broadcast"),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        navProvider.changeIndex(1);
                      },
                      child: navCardWidget(1, navProvider.index, "edit"),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        navProvider.changeIndex(2);
                      },
                      child: navCardWidget(2, navProvider.index, "globe"),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        navProvider.changeIndex(3);
                      },
                      child:
                          navCardWidget(3, navProvider.index, "notification"),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        navProvider.changeIndex(4);
                      },
                      child: navCardWidget(4, navProvider.index, "setting"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
