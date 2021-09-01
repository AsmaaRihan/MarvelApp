import 'package:Marvel_App/models/characters.dart';
import 'package:flutter/material.dart';

import 'charchter_card_item.dart';

class ListScreen extends StatefulWidget {
  Function onPress;
  List<Results> results;
  ListScreen({this.results, this.onPress});

  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: Colors.blueGrey[800],
        height: MediaQuery.of(context).size.height,
        child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: widget.results.length,
            itemBuilder: (ctx, i) {
              return Container(
                child: TextButton(
                    onPressed: widget.onPress(i),
                    child: CharacterCardItem(widget.results[i])),

                // Text(superhero.results[i].comics.items[i].name),
              );
            }),
      ),
    );
  }
}
