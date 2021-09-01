import 'package:flutter/material.dart';

class SearchTextItem extends StatelessWidget {
  TextEditingController textController;
  Function onChange;
  SearchTextItem({this.onChange, this.textController});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      child: TextField(
        textAlignVertical: TextAlignVertical.center,
        textInputAction: TextInputAction.done,
        controller: textController,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          contentPadding: new EdgeInsets.only(left: 16, right: 16),
          hintText: 'Search',
          prefixIcon: Icon(Icons.search),
        ),
        onChanged: onChange,
      ),
    );
  }
}
