import 'package:cosmic_post_office_main/screens/broadcast/view/broadcast_view.dart';
import 'package:cosmic_post_office_main/screens/notification/view/notification_view.dart';
import 'package:cosmic_post_office_main/screens/notification/view/show_notification_view.dart';
import 'package:cosmic_post_office_main/screens/orbits/view/orbits_view.dart';
import 'package:cosmic_post_office_main/screens/posting/view/posting_view.dart';
import 'package:cosmic_post_office_main/screens/profile/view/profile_view.dart';
import 'package:cosmic_post_office_main/screens/setting/view/change_password_view.dart';
import 'package:cosmic_post_office_main/screens/setting/view/setting_view.dart';
import 'package:flutter/material.dart';

class NavProvider with ChangeNotifier {
  int index = 0;
  var PagesAll = [
    BroadcastView(),
    PostingView(),
    OrbitsView(),
    NotificationView(),
    SettingView(),
    ProfileView(),
    ChangePasswordView(),
    ShowNotificationView(),
  ];

  changeIndex(int i) {
    index = i;
    notifyListeners();
  }
}
