import 'package:cached_network_image/cached_network_image.dart';
import 'package:cosmic_post_office_main/provider/auth_provider.dart';
import 'package:cosmic_post_office_main/screens/broadcast/provider/broadcast_provider.dart';
import 'package:cosmic_post_office_main/screens/nav/provider/nav_provider.dart';
import 'package:cosmic_post_office_main/screens/profile/view/profile_view.dart';
import 'package:cosmic_post_office_main/widgets/background_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;
import '../../../constant/constant_view.dart';

class BroadcastView extends StatefulWidget {
  const BroadcastView({Key? key}) : super(key: key);
  static const routeName = "/BroadcastView";

  @override
  State<BroadcastView> createState() => _BroadcastViewState();
}

class _BroadcastViewState extends State<BroadcastView> {
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
    await Provider.of<BroadcastProvider>(context, listen: false)
        .fetchOrbitData(isFetch);
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<BroadcastProvider>(context, listen: false);
    final user = Provider.of<AuthProvider>(context).user;

    final navProvider = Provider.of<NavProvider>(context);
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
                                "http://192.168.43.133:5000/public/userimage/${user['userImage']}"),
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
                  'Broadcasting',
                  style: TextStyle(color: Colors.grey, fontSize: 25),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            isLoading
                ? const Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  )
                : data.broadcastPost == null
                    ? data.error != null
                        ? Center(
                            child: Text(
                              data.error as String,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 30),
                            ),
                          )
                        : Center(
                            child: Text(
                              'No Results Found',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 30),
                            ),
                          )
                    : Expanded(
                        child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: data.broadcastPost!.length,
                            itemBuilder: (context, index) {
                              final item = data.broadcastPost![index];
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  child: Stack(
                                    children: [
                                      Container(
                                        child: Stack(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 20.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                  Container(
                                                    color: Constants
                                                        .textFiledColors
                                                        .withOpacity(0.5),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 70.0),
                                                          child: Text(
                                                            "${item['user']['userName']}",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 18),
                                                          ),
                                                        ),
                                                        Row(
                                                          children: [
                                                            Icon(
                                                              CupertinoIcons
                                                                  .arrow_left_right_circle_fill,
                                                              color:
                                                                  Colors.grey,
                                                            ),
                                                            SizedBox(
                                                              width: 20,
                                                            ),
                                                            Text(
                                                              "${item['date']}",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 18),
                                                            )
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  /*  CachedNetworkImage(
                                                    fit: BoxFit.cover,
                                                    imageUrl:
                                                        "https://imagecolorpicker.com/imagecolorpicker.png",
                                                    placeholder:
                                                        (context, url) =>
                                                            Center(
                                                      child:
                                                          CupertinoActivityIndicator(
                                                        radius: 40,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                    errorWidget:
                                                        (context, url, error) =>
                                                            Image.asset(
                                                      "assets/images/testing_broadcast.png",
                                                      width: double.infinity,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),*/

                                                  Container(
                                                    height: 200,
                                                    color: Constants
                                                        .textFiledColors
                                                        .withOpacity(0.5),
                                                    child: Image(
                                                        width: double.infinity,
                                                        fit: BoxFit.cover,
                                                        image: NetworkImage(
                                                            "https://cosmicbackend.invovision.io/${item['postImage']}")),
                                                  ),
                                                  Container(
                                                    width: double.infinity,
                                                    color: Constants
                                                        .textFiledColors
                                                        .withOpacity(0.5),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        item['title'] != null
                                                            ? Text(
                                                                "${item['title']}",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        23),
                                                              )
                                                            : Container(),
                                                        Text(
                                                          "${item['description']}",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 18),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Positioned(
                                              top: 0,
                                              left: 0,
                                              child:
                                                  'https://cosmicbackend.invovision.io${item['user']['userImage']}' !=
                                                          null
                                                      ? CircleAvatar(
                                                          backgroundColor:
                                                              Colors.black,
                                                          radius: 30,
                                                          backgroundImage:
                                                              NetworkImage(
                                                                  "http://192.168.43.133:5000/public/userimage/${item['user']['userImage']}"),
                                                        )
                                                      : CircleAvatar(
                                                          radius: 30,
                                                        ),
                                            ),
                                          ],
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
