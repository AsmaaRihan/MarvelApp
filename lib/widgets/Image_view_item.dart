import 'package:flutter/material.dart';

class ImageView extends StatelessWidget {
  String path;
  double w, h;
  ImageView({this.h, this.path, this.w});
  @override
  Widget build(BuildContext context) {
    return FadeInImage(
      height: h,
      width: w,
      placeholder: AssetImage('assets/images/loading.gif'),
      fit: BoxFit.fill,
      image: NetworkImage(path),
    );
  }
}
