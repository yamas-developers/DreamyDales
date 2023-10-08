import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../common_widgets/public_methods.dart';
import '../../constants.dart';
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        elevation: 5,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_outlined,
            color: whiteColor,
            size: 25,
          ),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        title: PublicText(
          title: "Settings",
          fontSize: 19,
          fontWeight: FontWeight.w500,
          titleColor: whiteColor,
        ),
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [mainColor, primaryColor],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Column(
              children: [
                SizedBox(height: 8,),
                SettingsWidget(
                  title: "Rate the App",
                  image: "assets/icons/star.png",
                  onTap: (){
                    showAlertDialog(
                      context,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 17),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 16),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  PublicText(
                                    title: "I LIKE THE APP",
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    titleColor: mainColor,
                                  ),
                                  Sbw(width: 0.015,),
                                  Icon(
                                    Icons.thumb_up_alt_rounded,
                                    color: accentColor,
                                    size: 20
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 25),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  PublicText(
                                    title: "I DON'T LIKE THE APP",
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    titleColor: mainColor,
                                  ),
                                  Sbw(width: 0.015,),
                                  Icon(
                                    Icons.thumb_down_alt_rounded,
                                    color: accentColor,
                                    size: 20
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top:2,bottom: 12),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  GestureDetector(
                                    onTap: () async {
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      "CANCEL", style: TextStyle(
                                        color: blackColor.withOpacity(0.5),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16
                                    ),),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                  height: 23,
                  width: 23,
                ),
                SettingsWidget(
                  title: "Privacy Policy",
                  image: "assets/icons/privacy_policy.png",
                  onTap: (){
                    showAlertDialog(
                      context,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 17),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 14),
                              child: PublicText(
                                title: "Privacy Policy",
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                titleColor: blackColor,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: PublicText(
                                title: "We do not collect or share data. The\n"
                                    "app is ad-free and 100% kid-safe.\n\n"
                                    "Contact email:info.stasapps@gmail\n.com",
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                titleColor: blackColor,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top:12,bottom: 12),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  GestureDetector(
                                    onTap: () async {
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      "OK", style: TextStyle(
                                        color: mainColor,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16
                                    ),),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                  height: 25,
                  width: 25,
                ),
                SettingsWidget(
                  title: "Restore Purchases",
                  image: "assets/icons/purchase.png",
                  onTap: (){
                    showAlertDialog(
                      context,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 17),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 14),
                              child: PublicText(
                                title: "Please click the BUY button again.\n"
                                    "Your purchases will be restored and\n"
                                    "the money will not be debited. The\n"
                                    "purchase account must match\nthe current account",
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                titleColor: blackColor,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top:12,bottom: 12),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  GestureDetector(
                                    onTap: () async {
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      "OK", style: TextStyle(
                                        color: mainColor,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16
                                    ),),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                  height: 25,
                  width: 25,
                ),
                SettingsWidget(
                  title: "Contact Us",
                  image: "assets/icons/contact_us.png",
                  onTap: (){
                    showAlertDialog(
                      context,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 17),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 14),
                              child: PublicText(
                                title: "If you have any question, please\n"
                                    "email us at info.stasapp@gmail\n.com",
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                titleColor: blackColor,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top:12,bottom: 12),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  GestureDetector(
                                    onTap: () async {
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      "OK", style: TextStyle(
                                        color: mainColor,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16
                                    ),),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                  height: 25,
                  width: 25,
                ),
                SettingsWidget(
                  title: "Share the App",
                  image: "assets/icons/share.png",
                  onTap: (){
                    showAlertDialog(
                      context,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 17),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 14),
                              child: PublicText(
                                title: "Please, share the link to the app\nwith your friends",
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                titleColor: blackColor,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top:15,bottom: 12),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  GestureDetector(
                                    onTap: () async {
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      "OK", style: TextStyle(
                                        color: mainColor,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16
                                    ),),
                                  ),
                                  Sbw(width: 0.1,),
                                  GestureDetector(
                                    onTap: () async {
                                      await Clipboard.setData(ClipboardData(text: "Link"));
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      "COPY THE LINK", style: TextStyle(
                                        color: mainColor,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16
                                    ),),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                  height: 23,
                  width: 23,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      PublicText(
                        title: "I know that it is hard sometimes for a child to go to sleep. So,\n"
                            "with the help of child psychologists and sleep consultants, I\n"
                            "have developed a unique approach. Simply turn on my audio\n"
                            "stories for your child before bed. The relaxing background\n"
                            "music, soothing narrator's voice, and enhancing storyline will\n"
                            "help your child settle down and fall asleep. I create exclusive\n"
                            "quality content. The number of stories in audio library is\n"
                            "constantly growing!\n\nTo my children. Forever and ever.",
                        fontSize: 11.8,
                        fontWeight: FontWeight.w500,
                        titleColor: whiteColor,
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class SettingsWidget extends StatelessWidget {
  const SettingsWidget({
    super.key, required this.image, required this.title, required this.onTap,
    this.height=20,this.width=20,
  });
  final String image;
  final String title;
  final VoidCallback onTap;
  final double height;
  final double width;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ListTile(
          leading: Image.asset(
            image,
            height: height,
            color: accentColor,
            width: width),
          title: PublicText(
            title: title,
            fontSize: 17,
            fontWeight: FontWeight.w400,
            titleColor: whiteColor,
          ),
      ),
    );
  }
}
