import 'package:cosmic_post_office_main/provider/auth_provider.dart';
import 'package:cosmic_post_office_main/screens/nav/provider/nav_provider.dart';
import 'package:cosmic_post_office_main/screens/orbits/provider/orbit_provider.dart';
import 'package:cosmic_post_office_main/widgets/background_widget.dart';
import 'package:flutter/material.dart';

import 'dart:math' as math;
import 'package:cosmic_post_office_main/constant/constant_view.dart';
import 'package:provider/provider.dart';
import '../../broadcast/provider/broadcast_provider.dart';

class MissionStatusView extends StatefulWidget {
  const MissionStatusView({Key? key}) : super(key: key);
  static const routeName = "/MissionStatusView";
  @override
  State<MissionStatusView> createState() => _MissionStatusViewState();
}

class _MissionStatusViewState extends State<MissionStatusView> {
  bool isLoading = false;
  @override
  void initState() {
    final data =
        Provider.of<BroadcastProvider>(context, listen: false).broadcastPost;
    if (data == null) {
      fetchData(true);
    }
    fetchData(true);
    super.initState();
  }

  fetchData(bool isFetch) async {
    setState(() => isLoading = true);
    final user = await Provider.of<AuthProvider>(context, listen: false).user;
    await Provider.of<OrbitProvider>(context, listen: false)
        .fetchOrbitData(isFetch, user['_id']);
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    final navProvider = Provider.of<NavProvider>(context);
    final data = Provider.of<OrbitProvider>(context, listen: false);
    final user = Provider.of<AuthProvider>(context).user;
    return Background(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Mission Status"),
          backgroundColor: Constants.textFiledColors.withOpacity(0.5),
        ),
        backgroundColor: Colors.transparent,
        body: SafeArea(
            child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
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
                                  "http://192.168.0.117:5000/public/userimage/${user['userImage']}"),
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
                    'Mission Status',
                    style: TextStyle(color: Colors.grey, fontSize: 25),
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12.0, bottom: 8),
                child: Text(
                  "Checkpoints",
                  style: TextStyle(color: Colors.grey, fontSize: 20),
                ),
              ),
              isLoading
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    )
                  : data.orbitPost == null
                      // ignore: unnecessary_null_comparison
                      ? data.error != null
                          ? Center(
                              child: Text(
                                data.error as String,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 30),
                              ),
                            )
                          : Center(
                              child: Text(
                                'No Results Found',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 30),
                              ),
                            )
                      : Container(
                          color: Constants.textFiledColors.withOpacity(0.5),
                          child: ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: data.orbitPost!.length,
                              itemBuilder: (context, index) {
                                final item = data.orbitPost![index];
                                return item['status'] == '0'
                                    ? Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          child: item['title'] != null
                                              ? Row(
                                                  children: [
                                                    Checkbox(
                                                        activeColor:
                                                            Colors.black,
                                                        value: item['status'] ==
                                                                '1'
                                                            ? true
                                                            : false,
                                                        onChanged:
                                                            (value) async {
                                                          await data.postUpdate(
                                                              id: item['_id'],
                                                              status: "1");
                                                          await fetchData(true);
                                                        }),
                                                    Text(
                                                      "${item['title']}",
                                                      style: TextStyle(
                                                          color: Colors.grey),
                                                    )
                                                  ],
                                                )
                                              : Container(),
                                        ),
                                      )
                                    : Container();
                              }),
                        ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0, bottom: 8),
                      child: Text(
                        "Complete",
                        style: TextStyle(color: Colors.grey, fontSize: 20),
                      ),
                    ),
                    Container(
                      //   height: 200,
                      color: Colors.grey.withOpacity(0.5),
                      child: ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: data.orbitPost?.length,
                          itemBuilder: (context, index) {
                            final item = data!.orbitPost![index];
                            return item['status'] == '1'
                                ? Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      child: item['title'] != null
                                          ? Row(
                                              children: [
                                                Checkbox(
                                                    activeColor: Colors.black,
                                                    value: item['status'] == '1'
                                                        ? true
                                                        : false,
                                                    onChanged: (value) async {
                                                      await data.postUpdate(
                                                          id: item['_id'],
                                                          status: "0");
                                                      fetchData(true);
                                                    }),
                                                Text(
                                                  "${item['title']}",
                                                  style: TextStyle(
                                                      color: Colors.grey),
                                                )
                                              ],
                                            )
                                          : Container(),
                                    ),
                                  )
                                : Container();
                          }),
                    ),
                    SizedBox(
                      height: 30,
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
