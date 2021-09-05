import 'package:Marvel_App/models/characters.dart';
import 'package:Marvel_App/widgets/Image_view_item.dart';
import 'package:Marvel_App/widgets/comic_image.dart';
import 'package:flutter/material.dart';

class ComicDetailedItem extends StatelessWidget {
  String path, extension, name, len, pos;
  Data superhero;
  ComicDetailedItem(
      {this.path,
      this.extension,
      this.name,
      this.superhero,
      this.len,
      this.pos});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 5, 5, 5),
        child: Column(
          children: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => ComicImage(
                          imagePath: path,
                          imageExtension: extension,
                          name: name,
                          superhero: superhero,
                          len: len,
                          pos: pos)));
                },
                child: ImageView(
                  h: 180,
                  w: 100,
                  path: '${path}.${extension}',
                )),
            SizedBox(height: 5),
            Container(
              width: 100,
              child: Text(
                name,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
