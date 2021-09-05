import 'package:Marvel_App/models/comics.dart';
import 'package:Marvel_App/models/characters.dart';
import 'package:Marvel_App/widgets/detailedScreen/comic_detail_item.dart';
import 'package:Marvel_App/widgets/detailedScreen/title_tem.dart';
import 'package:flutter/material.dart';

class ComicItem extends StatelessWidget {
  Comics comicItem;
  Data superhero;
  String comicTitle;
  ComicItem({this.comicItem, this.comicTitle, this.superhero});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleItem(title: comicTitle),
        comicItem.items.length != 0
            ? Container(
                height: 250,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: comicItem.items.length,
                    itemBuilder: (ctx, i) {
                      return ComicDetailedItem(
                          path: '${superhero.results[0].thumbnail.path}',
                          extension:
                              '${superhero.results[0].thumbnail.extension}',
                          name: comicItem.items[i].name,
                          superhero: superhero,
                          len: comicItem.items.length.toString(),
                          pos: i.toString());
                    }),
              )
            : Container(),
      ],
    );
  }
}
