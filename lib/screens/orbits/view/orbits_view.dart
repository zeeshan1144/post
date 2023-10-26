import 'package:cosmic_post_office_main/provider/auth_provider.dart';
import 'package:cosmic_post_office_main/screens/nav/provider/nav_provider.dart';
import 'package:cosmic_post_office_main/screens/orbits/provider/orbit_provider.dart';
import 'package:cosmic_post_office_main/widgets/background_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;

import '../../../constant/constant_view.dart';

class OrbitsView extends StatefulWidget {
  const OrbitsView({Key? key}) : super(key: key);
  static const routeName = "/OrbitsView";
  @override
  State<OrbitsView> createState() => _OrbitsViewState();
}

class _OrbitsViewState extends State<OrbitsView> {
  bool isLoading = false;
  @override
  void initState() {
    final data = Provider.of<OrbitProvider>(context, listen: false).orbitPost;
    if (data == null) {
      fetchData(true);
    }
    fetchData(true);
    super.initState();
  }

  fetchData(bool isFetch) async {
    final user = await Provider.of<AuthProvider>(context, listen: false).user;
    setState(() => isLoading = true);
    await Provider.of<OrbitProvider>(context, listen: false)
        .fetchOrbitData(isFetch, user['_id']);
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<OrbitProvider>(context, listen: false);
    final navProvider = Provider.of<NavProvider>(context, listen: true);
    final user = Provider.of<AuthProvider>(context).user;

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
                  'Orbits',
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
                : data.orbitPost == null
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
                            itemCount: data.orbitPost!.length,
                            itemBuilder: (context, index) {
                              final item = data.orbitPost![index];
                              return GestureDetector(
                                onTap: () {},
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    color: Constants.textFiledColors
                                        .withOpacity(0.5),
                                    padding: const EdgeInsets.all(5.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "${item['user']['userName']}",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              "${item['date']}",
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 3,
                                        ),
                                        Container(
                                          height: 200,
                                          color: Constants.textFiledColors
                                              .withOpacity(0.5),
                                          child: Image(
                                              width: double.infinity,
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                  "http://192.168.43.133:5000/public/postImage/${item['postImage']}")),
                                        ),
                                        SizedBox(
                                          height: 3,
                                        ),
                                        Text(
                                          "${item['description']}",
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
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
