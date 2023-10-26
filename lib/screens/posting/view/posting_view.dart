import 'dart:io';

import 'package:cosmic_post_office_main/helper/snackbar/snackbar_messages.dart';
import 'package:cosmic_post_office_main/provider/auth_provider.dart';
import 'package:cosmic_post_office_main/screens/nav/provider/nav_provider.dart';
import 'package:cosmic_post_office_main/screens/posting/provider/posting_provider.dart';
import 'package:cosmic_post_office_main/screens/posting/view/mission_status_view.dart';
import 'package:cosmic_post_office_main/widgets/background_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;

import '../../../constant/constant_view.dart';
import '../../../widgets/textformfiled_widget.dart';

class PostingView extends StatefulWidget {
  const PostingView({Key? key}) : super(key: key);
  static const routeName = "/PostingView";

  @override
  State<PostingView> createState() => _PostingViewState();
}

class _PostingViewState extends State<PostingView> {
  TextEditingController txtPostDescription = TextEditingController();
  TextEditingController txtPostTitle = TextEditingController();
  final DateTime dateNow = DateTime.now();
  File? image;
  final picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    var inputFormat = DateFormat('MM/dd/yyyy');
    String date = inputFormat.format(dateNow);
    final navProvider = Provider.of<NavProvider>(context);
    final user = Provider.of<AuthProvider>(context).user;
    final post = Provider.of<PostingProvider>(context, listen: false);

    return Background(
      child: ProgressHUD(
        child: Builder(builder: (context) {
          return Scaffold(
            backgroundColor: Colors.transparent,
            body: SafeArea(
                child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 12.0, left: 12.0, right: 12.0),
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
                        'Posting',
                        style: TextStyle(color: Colors.grey, fontSize: 25),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(20),
                          color: Constants.textFiledColors.withOpacity(0.5),
                          child: Text(
                            "Send your dreams to the Cosmic Post Office and allow the universe to manifest!",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        TextFormFiledWidget(
                          controller: txtPostTitle,
                          maxLines: 1,
                          hint: "Your Mission...?",
                          textInputAction: TextInputAction.next,
                          validate: (value) {},
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        TextFormFiledWidget(
                          controller: txtPostDescription,
                          maxLines: 8,
                          hint: "What are your dreams?",
                          textInputAction: TextInputAction.newline,
                          validate: (value) {},
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        image != null
                            ? GestureDetector(
                                onTap: () {
                                  imagePicked();
                                },
                                child: SizedBox(
                                  height: 200,
                                  child: Image(
                                    image: FileImage(File(image!.path)),
                                  ),
                                ),
                              )
                            : GestureDetector(
                                onTap: () {
                                  imagePicked();
                                },
                                child: Icon(
                                  Icons.image,
                                  size: 150,
                                  color: Colors.white,
                                ),
                              ),
                        SizedBox(
                          height: 20,
                        ),
                        CupertinoButton(
                          child: Text(
                            "Send it!",
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic),
                          ),
                          onPressed: () async {
                            final progress = ProgressHUD.of(context);

                            setState(() {
                              progress!.showWithText('Uploading...');
                            });
                            await post.uploadPost(
                                context: context,
                                uid: user['_id'],
                                title: txtPostTitle.text,
                                description: txtPostDescription.text,
                                date: '$date',
                                pickedImage: image!);
                            setState(() {
                              txtPostTitle.clear();
                              txtPostDescription.clear();
                              image = null;

                              progress!.dismiss();
                            });
                          },
                          color: Colors.grey.shade200,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CupertinoButton(
                          child: Text(
                            "Mission Status",
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic),
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MissionStatusView()));
                          },
                          color: Colors.grey.shade200,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )),
          );
        }),
      ),
    );
  }

  imagePicked() async {
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        image = File(picked.path);
      });
    }
  }
}
