import 'package:cosmic_post_office_main/constant/routes.dart';
import 'package:cosmic_post_office_main/provider/auth_provider.dart';
import 'package:cosmic_post_office_main/screens/login/view/login_view.dart';
import 'package:cosmic_post_office_main/screens/nav/provider/nav_provider.dart';
import 'package:cosmic_post_office_main/screens/nav/view/master_page.dart';
import 'package:cosmic_post_office_main/screens/notification/provider/notificaion_provider.dart';
import 'package:cosmic_post_office_main/screens/orbits/provider/orbit_provider.dart';
import 'package:cosmic_post_office_main/screens/posting/provider/posting_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../screens/broadcast/provider/broadcast_provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => NavProvider()),
        ChangeNotifierProvider(create: (_) => OrbitProvider()),
        ChangeNotifierProvider(create: (_) => NotificationProvider()),
        ChangeNotifierProvider(create: (_) => PostingProvider()),
        ChangeNotifierProvider(create: (_) => BroadcastProvider()),
      ],
      child: Consumer<AuthProvider>(builder: (ctx, auth, child) {
        return MaterialApp(
          key: Key(DateTime.now().toString()),
          debugShowCheckedModeBanner: false,
          title: "Cosmic",
          routes: getRoutes(context),
          home: auth.isAuthenticated
              ? const MasterPage()
              : FutureBuilder(
                  future: auth.loadUser(),
                  builder: (context, AsyncSnapshot snapshot) {
                    return snapshot.connectionState == ConnectionState.waiting
                        ? const Center(child: CircularProgressIndicator())
                        : LoginView();
                  },
                ),
        );
      }),
    );
  }
}
