import 'package:Marvel_App/screens/character_details_screen.dart';
import 'package:flutter/material.dart';

import 'models/characters.dart';
import 'widgets/Image_view_item.dart';

class ComicImage extends StatelessWidget {
  String imagePath, imageExtension, name, len, pos;
  Data superhero;
  ComicImage(
      {this.imageExtension,
      this.imagePath,
      this.name,
      this.superhero,
      this.len,
      this.pos});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[800],
      body: Stack(
        children: [
          Center(
            child: Container(
                child: ImageView(
              h: 450,
              w: 300,
              path: '${this.imagePath}.${this.imageExtension}',
            )),
          ),
          Positioned(
            top: 550,
            left: MediaQuery.of(context).size.width * .2,
            child: Center(
              child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    name,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                    textAlign: TextAlign.center,
                  )),
            ),
          ),
          Positioned(
            top: 580,
            left: MediaQuery.of(context).size.width * .41,
            child: Center(
              child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    '${pos}/${len}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                    textAlign: TextAlign.center,
                  )),
            ),
          ),
          Positioned(
            top: 20,
            right: 0,
            child: IconButton(
                icon: Icon(Icons.close, color: Colors.white),
                onPressed: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => CharacterDetails(
                            superhero: superhero,
                          )));
                }),
          )
        ],
      ),
    );
  }
}

//  Container(
//             width: 100,
//             child: Text(
//               name,
//               textAlign: TextAlign.center,
//               style: TextStyle(fontSize: 6, color: Colors.white),
//             ),
//           ),
