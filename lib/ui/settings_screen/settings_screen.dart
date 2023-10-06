import 'package:flutter/material.dart';

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
                  onTap: (){},
                  height: 23,
                  width: 23,
                ),
                SettingsWidget(
                  title: "Privacy Policy",
                  image: "assets/icons/privacy_policy.png",
                  onTap: (){},
                  height: 25,
                  width: 25,
                ),
                SettingsWidget(
                  title: "Restore Purchases",
                  image: "assets/icons/purchase.png",
                  onTap: (){},
                  height: 25,
                  width: 25,
                ),
                SettingsWidget(
                  title: "Contact Us",
                  image: "assets/icons/contact_us.png",
                  onTap: (){},
                  height: 25,
                  width: 25,
                ),
                SettingsWidget(
                  title: "Share the App",
                  image: "assets/icons/share.png",
                  onTap: (){},
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
            color: yellowColor,
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
