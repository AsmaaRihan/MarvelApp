import 'package:flutter/material.dart';

class TitleItem extends StatelessWidget {
  String title;

  TitleItem({this.title});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10),
        Text(title,
            style: TextStyle(
              color: Colors.red,
              fontSize: 16,
            )),
      ],
    );
  }
}
