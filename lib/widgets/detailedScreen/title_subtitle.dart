import 'package:flutter/material.dart';

class TitleSubtitle extends StatelessWidget {
  String title, content;
  TitleSubtitle({this.content, this.title});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.red, fontSize: 16),
        ),
        Container(
          child: content != ''
              ? Text(
                  content,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold),
                )
              : Text(
                  'No description',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold),
                ),
        ),
      ],
    );
  }
}
