import 'dart:async';
import 'package:cosmic_post_office_main/constant/constant_view.dart';
import 'package:cosmic_post_office_main/provider/auth_provider.dart';
import 'package:cosmic_post_office_main/screens/nav/provider/nav_provider.dart';
import 'package:cosmic_post_office_main/screens/notification/model/notification_model.dart';
import 'package:cosmic_post_office_main/screens/notification/provider/notificaion_provider.dart';
import 'package:cosmic_post_office_main/widgets/background_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:math' as math;

import 'package:provider/provider.dart';

class ShowNotificationView extends StatefulWidget {
  final receiverId;
  final senderId;
  ShowNotificationView({Key? key, this.receiverId, this.senderId})
      : super(key: key);
  static const routeName = "/ShowNotificationView";

  @override
  State<ShowNotificationView> createState() => _ShowNotificationViewState();
}

class _ShowNotificationViewState extends State<ShowNotificationView> {
  List<NotificationModel> list = [
    NotificationModel(
        name: "Khan", title: "Message", message: "Hi Khan", date: "08/02/2022"),
    NotificationModel(
        name: "Ak", title: "Message", message: "Hi Khan", date: "08/02/2022"),
  ];
  Timer? _timer;
  late Future<dynamic> _ChatList;
  TextEditingController controller = TextEditingController();
  bool isLoading = false;
  @override
  void initState() {
    _ChatList =
        Provider.of<NotificationProvider>(context, listen: false).receive(
      isLoad: true,
      senderId: '${widget.senderId}',
      receiverId: '${widget.receiverId}',
    );
    if (widget.receiverId != null) {
      _timer =
          new Timer.periodic(Duration(milliseconds: 2200), (Timer timer) async {
        fetchData(true);
      });
    }

    super.initState();
  }

  fetchData(bool isFetch) async {
    setState(() {
      _ChatList =
          Provider.of<NotificationProvider>(context, listen: false).receive(
        isLoad: true,
        senderId: '${widget.senderId}',
        receiverId: '${widget.receiverId}',
      );
    });
  }

  final ScrollController listScrollController = ScrollController();
  @override
  void dispose() {
    _timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final navProvider = Provider.of<NavProvider>(context);
    final user = Provider.of<AuthProvider>(context).user;
    final messagePr = Provider.of<NotificationProvider>(context, listen: false);
    return Background(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Messages"),
          backgroundColor: Constants.textFiledColors.withOpacity(0.5),
        ),
        backgroundColor: Colors.transparent,
        body: SafeArea(
            child: Column(
          children: [
            Expanded(
              child: FutureBuilder<dynamic>(
                future: _ChatList,
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text("No chat history"),
                    );
                  } else if (snapshot.hasData) {
                    return ListView.builder(
                        shrinkWrap: true,
                        controller: listScrollController,
                        reverse: true,
                        itemCount: snapshot.data!.length,
                        padding: EdgeInsets.all(10),
                        itemBuilder: (context, index) {
                          final items = snapshot.data![index];
                          if (items['senderId'] == widget.senderId) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(right: 30.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Container(
                                            color: Colors.grey.withOpacity(0.5),
                                            padding: EdgeInsets.only(
                                                left: 5, right: 10, bottom: 12),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  "${items['sender']['userName']}",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 23),
                                                ),
                                                Text(
                                                  "${items['message']}",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            );
                          } else {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(right: 30.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Container(
                                            color: Colors.grey.withOpacity(0.5),
                                            padding: EdgeInsets.only(
                                                left: 5, right: 10, bottom: 12),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  "${items['receiver']['userName']}",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 23),
                                                ),
                                                Text(
                                                  "${items['message']}",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }
                        });
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: createInput(senderId: user['_id']),
            )
          ],
        )),
      ),
    );
  }

  createInput({required String senderId}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(top: 3, bottom: 5),
      height: 70.0,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Colors.grey, width: 0.5))),
      child: Row(
        children: [
          Flexible(
            child: Container(
              padding: EdgeInsets.only(left: 10),
              child: TextField(
                controller: controller,
                style: TextStyle(fontSize: 15.0),
                decoration: InputDecoration.collapsed(
                  hintText: 'write here.....',
                  hintStyle: TextStyle(color: Colors.grey),
                ),
                //  focusNode: focusNode,
              ),
            ),
          ),
          IconButton(
              onPressed: () async {
                String msgContent = controller.text.replaceAll('\'', "\\'");
                //String myTime = DateFormat("yyyy-MM-dd HH:mm:ss").format(now);
                String myTime =
                    DateTime.now().millisecondsSinceEpoch.toString();
                /* await Provider.of<NotificationProvider>(context, listen: false)
                    .send(context,
                        senderId: widget.senderId,
                        receiverId: widget.receiverId!,
                        message: msgContent);*/
                print("SenderID:${widget.senderId}");
                print("ReceiverID:${widget.receiverId}");
                controller.clear();
              },
              icon: Icon(
                Icons.send,
                size: 30,
              )),
        ],
      ),
    );
  }
}
