import 'package:Marvel_App/bloc/marvel_bloc.dart';
import 'package:Marvel_App/models/characters.dart';
import 'package:Marvel_App/widgets/Image_view_item.dart';
import 'package:Marvel_App/widgets/charchter_card_item.dart';
import 'package:Marvel_App/widgets/loader.dart';
import 'package:Marvel_App/widgets/search_item.dart';
import 'package:clippy_flutter/paralellogram.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import 'character_details_screen.dart';

class CharchtersListSreen extends StatefulWidget {
  @override
  _CharchtersListSreenState createState() => _CharchtersListSreenState();
}

class _CharchtersListSreenState extends State<CharchtersListSreen> {
  final TextEditingController _search = TextEditingController();

  bool search = false;
  Data superhero;

  MarvelBloc marvelBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    marvelBloc = MarvelBloc();

    marvelBloc.add(GetCharacters(
        path: 'characters?limit=20',
        searchWay: "ByCharacters",
        searchedText: ""));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    marvelBloc.close();
    _search.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.blueGrey[800],
        appBar: AppBar(
          backgroundColor: Colors.black,
          actions: [
            search
                ? TextButton(
                    onPressed: () => setState(() {
                          search = !search;
                          _search.clear();
                          marvelBloc.add(GetCharacters(
                              path: 'characters?limit=20',
                              searchWay: "ByCharacters",
                              searchedText: ""));
                        }),
                    child: Text(
                      'cancel',
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: 12,
                          fontWeight: FontWeight.normal),
                    ))
                : IconButton(
                    icon: Icon(Icons.search, color: Colors.red),
                    onPressed: () {
                      setState(() {
                        search = !search;
                      });
                    },
                    color: Colors.black,
                  ),
          ],
          centerTitle: true,
          title: search
              ? SearchTextItem(
                  textController: _search,
                  onChange: (_) {
                    print("SEARCHTERM: " + _search.text.trim().toString());
                    marvelBloc.add(GetCharacters(
                        path: 'characters?nameStartsWith=',
                        searchWay: 'BySearchTerm',
                        searchedText: '${_search.text.trim()}'));
                  })
              : SvgPicture.asset(
                  'assets/images/marvelLogo.svg',
                  height: 30.0,
                  width: 150.0,
                ),
        ),
        body: BlocProvider(
          create: (context) => marvelBloc,
          child: BlocListener<MarvelBloc, MarvelState>(
            listener: (context, state) {
              if (state is GetCharactersByNameState) {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CharacterDetails(
                              superhero: state.superhero,
                            )));
              }
            },
            child: BlocBuilder<MarvelBloc, MarvelState>(
              builder: (context, state) {
                if (state is GetAllCharactersState) {
                  return search
                      ? Container(
                          color: Colors.blueGrey[800],
                        )
                      : SingleChildScrollView(
                          child: Container(
                            color: Colors.blueGrey[800],
                            height: MediaQuery.of(context).size.height,
                            child: ListView.builder(
                                scrollDirection: Axis.vertical,
                                itemCount: state.superhero.results.length,
                                itemBuilder: (ctx, i) {
                                  return Container(
                                    child: TextButton(
                                        onPressed: () => marvelBloc.add(
                                            GetCharacters(
                                                path: "characters?id=",
                                                searchWay: "ById",
                                                searchedText:
                                                    "${state.superhero.results[i].id}")),
                                        child: CharacterCardItem(
                                            state.superhero.results[i])),

                                    // Text(superhero.results[i].comics.items[i].name),
                                  );
                                }),
                          ),
                        );
                } else if (state is GetCharactersBySearchTermState) {
                  return buildSeachByTerm(context, state);
                } else {
                  return LoaderWidget();
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  SingleChildScrollView buildSeachByTerm(
      BuildContext context, GetCharactersBySearchTermState state) {
    return SingleChildScrollView(
      child: Container(
        color: Colors.blueGrey[900],
        height: MediaQuery.of(context).size.height,
        child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: state.superhero.results.length,
            itemBuilder: (ctx, i) {
              return TextButton(
                onPressed: () => marvelBloc.add(GetCharacters(
                    path: "characters?id=",
                    searchWay: "ById",
                    searchedText: "${state.superhero.results[i].id}")),
                child: Row(
                  children: [
                    ImageView(
                      h: 80,
                      w: 80,
                      path:
                          '${state.superhero.results[i].thumbnail.path}.${state.superhero.results[i].thumbnail.extension}',
                    ),
                    SizedBox(width: 5),
                    Container(
                      child: Text(
                        state.superhero.results[i].name,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
