import 'package:flutter/material.dart';
class Background extends StatelessWidget {
  final Widget child;
  const Background({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center, // get children to center
        children: [
          Positioned(
            top: 0, // all top position is 0
            left: 0, // all left position is 0
            child: Image.asset(
              "assets/images/main_top.png",
              width: size.width * 0.3,
            ), //image semi circle
          ),
          Positioned(
            bottom: 0, // all top position is 0
            left: 0, // all left position is 0
            child: Image.asset(
              "assets/images/main_bottom.png",
              width: size.width * 0.2,
            ), //image semi circle
          ),
          child,
        ],
      ),
    );
  }
}
