import 'package:cosmic_post_office_main/screens/broadcast/view/broadcast_view.dart';
import 'package:cosmic_post_office_main/screens/login/view/login_view.dart';
import 'package:cosmic_post_office_main/screens/notification/view/notification_view.dart';
import 'package:cosmic_post_office_main/screens/notification/view/show_notification_view.dart';
import 'package:cosmic_post_office_main/screens/orbits/view/orbits_view.dart';
import 'package:cosmic_post_office_main/screens/orbits/view/show_orbits_post.dart';
import 'package:cosmic_post_office_main/screens/posting/view/mission_status_view.dart';
import 'package:cosmic_post_office_main/screens/posting/view/posting_view.dart';
import 'package:cosmic_post_office_main/screens/profile/view/profile_view.dart';
import 'package:cosmic_post_office_main/screens/setting/view/change_password_view.dart';
import 'package:cosmic_post_office_main/screens/setting/view/setting_view.dart';
import 'package:cosmic_post_office_main/screens/signup/view/signup_view.dart';
import 'package:flutter/material.dart';

Map<String, Widget Function(BuildContext)> getRoutes(BuildContext ctx) {
  return {
    LoginView.routeName: (ctx) => LoginView(),
    BroadcastView.routeName: (ctx) => const BroadcastView(),
    NotificationView.routeName: (ctx) => const NotificationView(),
    ShowNotificationView.routeName: (ctx) => ShowNotificationView(),
    OrbitsView.routeName: (ctx) => const OrbitsView(),
    ShowOrbitsPost.routeName: (ctx) => const ShowOrbitsPost(),
    MissionStatusView.routeName: (ctx) => const MissionStatusView(),
    PostingView.routeName: (ctx) => const PostingView(),
    ProfileView.routeName: (ctx) => const ProfileView(),
    ChangePasswordView.routeName: (ctx) => ChangePasswordView(),
    SettingView.routeName: (ctx) => SettingView(),
    SignupView.routeName: (ctx) => SignupView(),
  };
}
