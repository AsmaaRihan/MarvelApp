import 'dart:ui';

import 'package:Marvel_App/bloc/marvel_bloc.dart';
import 'package:Marvel_App/main.dart';
import 'package:Marvel_App/models/comics.dart';
import 'package:Marvel_App/screens/charchters_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../comic_image.dart';
import '../models/characters.dart';
import '../models/items.dart';
import '../widgets/Image_view_item.dart';

// ignore: must_be_immutable
class CharacterDetails extends StatefulWidget {
  final Data superhero;
  CharacterDetails({@required this.superhero});

  @override
  _CharacterDetailsState createState() =>
      _CharacterDetailsState(superhero: this.superhero);
}

class _CharacterDetailsState extends State<CharacterDetails> {
  final Data superhero;
  _CharacterDetailsState({@required this.superhero});
  MarvelBloc marvelBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    marvelBloc = MarvelBloc();
    marvelBloc.add(GetComic(
        path: 'comics?id=',
        searchedText: '${superhero.results[0].id}',
        searchWay: "ByComic"));
  }

  @override
  void dispose() {
    super.dispose();
    marvelBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocProvider(
      create: (context) => marvelBloc,
      child: BlocBuilder<MarvelBloc, MarvelState>(
        builder: (context, state) {
          return buildSingleChildScrollView(context);
        },
      ),
    ));
  }

  SingleChildScrollView buildSingleChildScrollView(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                child: ImageView(
                  h: 350,
                  w: MediaQuery.of(context).size.width,
                  path:
                      '${superhero.results[0].thumbnail.path}.${superhero.results[0].thumbnail.extension}',
                ),
              ),
              Positioned(
                top: 30,
                child: IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios_outlined,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => CharchtersListSreen()));
                    }),
              ),
            ],
          ),
          Container(
            color: Colors.blueGrey[800],
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 10),
                  _buildContent("NAME", superhero.results[0].name),
                  SizedBox(height: 10),
                  _buildContent(
                      "Description", superhero.results[0].description),
                  buildComicItem(superhero.results[0].comics, 'COMICS', context,
                      superhero),
                  buildComicItem(superhero.results[0].series, 'SERIES', context,
                      superhero),
                  buildComicItem(superhero.results[0].stories, 'STORIES',
                      context, superhero),
                  buildComicItem(superhero.results[0].events, 'EVENTS', context,
                      superhero),
                  _buildTtitle("RELATED LINKS"),
                  SizedBox(height: 10),
                  _buildDetail("Detail", (Icons.arrow_forward_ios_outlined)),
                  SizedBox(height: 10),
                  _buildDetail("Wiki", (Icons.arrow_forward_ios_outlined)),
                  SizedBox(height: 10),
                  _buildDetail("ComicLink", (Icons.arrow_forward_ios_outlined)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Column buildComicItem(Comics comicItem, String comicTitle,
      BuildContext context, Data superhero) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTtitle(comicTitle),
        comicItem.items.length != 0
            ? Container(
                height: 250,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: comicItem.items.length,
                    itemBuilder: (ctx, i) {
                      return _buildComic(
                          '${superhero.results[0].thumbnail.path}',
                          '${superhero.results[0].thumbnail.extension}',
                          comicItem.items[i].name,
                          context,
                          superhero,
                          comicItem.items.length.toString(),
                          i.toString());
                    }),
              )
            : Container(),
      ],
    );
  }
}

Column _buildTtitle(String title) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 10),
      Text(title,
          style: TextStyle(
            color: Colors.red,
            fontSize: 12,
          )),
    ],
  );
}

Widget _buildDetail(String title, IconData iconData) {
  return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
    Text(title,
        style: TextStyle(
          color: Colors.white,
          fontSize: 12,
        )),
    Icon(iconData, color: Colors.white)
  ]);
}

Widget _buildContent(String title, var content) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.red, fontSize: 12),
      ),
      Container(
        child: content != ''
            ? Text(
                content,
                style: TextStyle(color: Colors.white, fontSize: 12),
              )
            : Text(
                'No description',
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
      ),
    ],
  );
}

Widget _buildComic(String imagePath, String imageExtension, String name,
    BuildContext context, Data superhero, String len, String pos) {
  return Container(
    child: Padding(
      padding: const EdgeInsets.fromLTRB(0, 5, 5, 5),
      child: Column(
        children: [
          TextButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => ComicImage(
                        imagePath: imagePath,
                        imageExtension: imageExtension,
                        name: name,
                        superhero: superhero,
                        len: len,
                        pos: pos)));
              },
              child: ImageView(
                h: 180,
                w: 100,
                path: '${imagePath}.${imageExtension}',
              )),
          SizedBox(height: 5),
          Container(
            width: 100,
            child: Text(
              name,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 6, color: Colors.white),
            ),
          ),
        ],
      ),
    ),
  );
}
