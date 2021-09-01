import 'package:Marvel_App/widgets/charchter_card_item.dart';
import 'package:Marvel_App/widgets/list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Marvel_App/blocs/SearchByIdBLoc/searchbyid_bloc.dart';
import 'package:Marvel_App/blocs/SearchByIdBLoc/searchbyid_event.dart';
import 'package:Marvel_App/blocs/SearchByIdBLoc/searchbyid_state.dart';

class AllCharacterScreen extends StatefulWidget {
  @override
  _AllCharacterScreenState createState() => _AllCharacterScreenState();
}

class _AllCharacterScreenState extends State<AllCharacterScreen> {
  SearchbyidBloc _searchbyidBloc;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _searchbyidBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _searchbyidBloc,
      child: BlocListener<SearchbyidBloc, SearchbyidState>(
        listener: (context, state) {},
        child: BlocBuilder<SearchbyidBloc, SearchbyidState>(
          builder: (context, state) {
            if (state is GetCharactersByNameState) {
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
                              onPressed: () => _searchbyidBloc.add(SearchById(
                                  path: "characters?id=",
                                  searchedText:
                                      "${state.superhero.results[i].id}")),
                              child: CharacterCardItem(
                                  state.superhero.results[i])),

                          // Text(superhero.results[i].comics.items[i].name),
                        );
                      }),
                ),
              );
            } else
              return Container();
          },
        ),
      ),
    );
  }
}

// ListScreen(
//                           results: state.superhero.results,
//                           onPress: (int i) {
//                             print('int i = $i');
//                             marvelBloc.add(GetCharacters(
//                                 path: "characters?id=",
//                                 searchWay: "ById",
//                                 searchedText:
//                                     "${state.superhero.results[i].id}"));
//                           },
//                         )
