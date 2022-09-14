import 'package:flutter/material.dart';

import '../../../components/shapespainter.dart';
import '../../../constants.dart';

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
      width: double.infinity,
      color: whitePrimaryColor,
      height: size.height,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 0, // all top position is 0
            child: CustomPaint(
              painter: ShapesPainter(),
              size: Size(size.height, size.width),
            ),
          ),
          // Positioned(
          //     top: 0,
          //     left: 0,
          //     child: Image.asset(
          //       "assets/images/main_top.png",
          //       width: size.width * 0.3,
          //     )),
          // Positioned(
          //     bottom: 0,
          //     right: 0,
          //     child: Image.asset(
          //       "assets/images/login_bottom.png",
          //       width: size.width * 0.4,
          //     )),
          child
        ],
      ),
    );
  }
}
