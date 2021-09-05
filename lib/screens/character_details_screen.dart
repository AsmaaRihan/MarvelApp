import 'dart:ui';

import 'package:Marvel_App/bloc/marvel_bloc.dart';
import 'package:Marvel_App/main.dart';
import 'package:Marvel_App/models/comics.dart';
import 'package:Marvel_App/screens/charchters_list_screen.dart';
import 'package:Marvel_App/widgets/detailedScreen/comicItem.dart';
import 'package:Marvel_App/widgets/detailedScreen/title_subtitle.dart';
import 'package:Marvel_App/widgets/detailedScreen/title_tem.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/comic_image.dart';
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
                  TitleSubtitle(
                      title: "NAME", content: superhero.results[0].name),
                  SizedBox(height: 10),
                  TitleSubtitle(
                      title: "Description",
                      content: superhero.results[0].description),
                  ComicItem(
                      comicItem: superhero.results[0].comics,
                      comicTitle: 'COMICS',
                      superhero: superhero),
                  ComicItem(
                      comicItem: superhero.results[0].series,
                      comicTitle: 'SERIES',
                      superhero: superhero),
                  ComicItem(
                      comicItem: superhero.results[0].stories,
                      comicTitle: 'STORIES',
                      superhero: superhero),
                  ComicItem(
                      comicItem: superhero.results[0].events,
                      comicTitle: 'EVENTS',
                      superhero: superhero),
                  TitleItem(title: "RELATED LINKS"),
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

  Widget _buildDetail(String title, IconData iconData) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(title,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          )),
      Icon(iconData, color: Colors.white)
    ]);
  }
}
