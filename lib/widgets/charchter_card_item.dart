import 'package:Marvel_App/models/characters.dart';
import 'package:clippy_flutter/paralellogram.dart';
import 'package:flutter/material.dart';

import 'Image_view_item.dart';

class CharacterCardItem extends StatelessWidget {
  Results result;
  CharacterCardItem(this.result);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
            child: ImageView(
                h: 150,
                w: MediaQuery.of(context).size.width,
                path:
                    '${result.thumbnail.path}.${result.thumbnail.extension}')),
        Positioned(
          bottom: 20,
          top: 100,
          left: 20,
          child: Parallelogram(
            cutLength: 10.0,
            edge: Edge.RIGHT,
            child: Container(
              color: Colors.white,
              width: 150.0,
              height: 50.0,
              child: Center(
                child: Text(
                  result.name,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 8,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
