import 'package:Marvel_App/bloc/marvel_bloc.dart';
import 'package:clippy_flutter/paralellogram.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import 'character_details.dart';
import 'models/characters.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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
              ? Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  child: TextField(
                    textAlignVertical: TextAlignVertical.center,
                    textInputAction: TextInputAction.done,
                    controller: _search,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      contentPadding: new EdgeInsets.only(left: 16, right: 16),
                      hintText: 'Search',
                      prefixIcon: Icon(Icons.search),
                    ),
                    onChanged: (_) {
                      print("SEARCHTERM: " + _search.text.trim().toString());
                      marvelBloc.add(GetCharacters(
                          path: 'characters?nameStartsWith=',
                          searchWay: 'BySearchTerm',
                          searchedText: '${_search.text.trim()}'));
                    },
                  ),
                )
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
                      : buildAllCharacters(context, state);
                } else if (state is GetCharactersBySearchTermState) {
                  return buildSeachByTerm(context, state);
                } else {
                  return buildLoadingWidget();
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  Center buildLoadingWidget() {
    return Center(
      child: Container(
        width: 150,
        height: 150,
        child: Theme(
          data: Theme.of(context).copyWith(accentColor: Colors.white),
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  SingleChildScrollView buildAllCharacters(
      BuildContext context, GetAllCharactersState state) {
    return SingleChildScrollView(
      child: Container(
        color: Colors.blueGrey[800],
        height: MediaQuery.of(context).size.height,
        child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: state.superhero.results.length,
            itemBuilder: (ctx, i) {
              return Container(
                child: TextButton(
                  onPressed: () => marvelBloc.add(GetCharacters(
                      path: "characters?id=",
                      searchWay: "ById",
                      searchedText: "${state.superhero.results[i].id}")),
                  child: Stack(
                    children: [
                      Container(
                        child: FadeInImage(
                          height: 150,
                          width: MediaQuery.of(context).size.width,
                          placeholder: AssetImage('assets/images/loading.gif'),
                          fit: BoxFit.fill,
                          image: NetworkImage(
                              '${state.superhero.results[i].thumbnail.path}.${state.superhero.results[i].thumbnail.extension}'),
                        ),
                      ),
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
                                state.superhero.results[i].name,
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
                  ),
                ),

                // Text(superhero.results[i].comics.items[i].name),
              );
            }),
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
                    FadeInImage(
                      height: 80,
                      width: 80,
                      placeholder: AssetImage('assets/images/loading.gif'),
                      fit: BoxFit.fill,
                      image: NetworkImage(
                          '${state.superhero.results[i].thumbnail.path}.${state.superhero.results[i].thumbnail.extension}'),
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
