import 'package:flutter/material.dart';

import '../constants.dart';


class PublicImage extends StatelessWidget {
  const PublicImage({Key? key,
    required this.image,
    this.height=20,
    this.width=20,
    // this.imageColor=whiteColor,
    this.fit=BoxFit.contain}) : super(key: key);
  final String image;
  final double height;
  final double width;
  final BoxFit fit;
  // final Color imageColor;
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      image,
      height:height,
      fit: fit,
      // color: imageColor,
      width: width,
    );
  }
}

class PublicText extends StatelessWidget {
  const PublicText({
    super.key,
    required this.title,
    this.titleColor=whiteColor,
    this.fontSize=12,
    this.fontWeight=FontWeight.bold
  });
  final String title;
  final double fontSize;
  final Color titleColor;
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
          color: titleColor,
          fontSize: fontSize,
          fontWeight: fontWeight
      ),
    );
  }
}

class Sbh extends StatelessWidget {
  const Sbh({Key? key, this.height=0.01}) : super(key: key);
  final double height;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height*height,
    );
  }
}
class Sbw extends StatelessWidget {
  const Sbw({Key? key, this.width=0.01}) : super(key: key);
  final double width;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width*width,
    );
  }
}
showAlertDialog(context, Widget child,
    {okButtonText = 'Ok',
      onPress = null,
      showCancelButton = true,
      dismissible = true}) {
  String icon;
  showGeneralDialog(
      context: context,
      barrierLabel: "Barrier",
      barrierDismissible: dismissible,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 400),
      transitionBuilder: (_, anim, __, child) {
        var begin = 0.5;
        var end = 1.0;
        var curve = Curves.bounceOut;
        if (anim.status == AnimationStatus.reverse) {
          curve = Curves.fastLinearToSlowEaseIn;
        }
        var tween =
        Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        return ScaleTransition(
          scale: anim.drive(tween),
          child: child,
        );
      },
      pageBuilder: (BuildContext alertContext, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return StatefulBuilder(
          builder: (context, setState) {
            return WillPopScope(
              onWillPop: () {
                return Future.value(dismissible);
              },
              child: Center(
                child: Container(
                  margin: const EdgeInsets.all(25),
                  child: SingleChildScrollView(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(3),
                      child: Material(
                        child: Container(
                          color: Colors.white,
                          padding: const EdgeInsets.all(5),
                          child: child
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      });
}