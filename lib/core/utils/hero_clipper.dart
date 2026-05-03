import 'package:flutter/material.dart';

class HeroClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 80);
    var cp = Offset(size.width / 2, size.height);
    var ep = Offset(size.width, size.height - 80);
    path.quadraticBezierTo(cp.dx, cp.dy, ep.dx, ep.dy);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
