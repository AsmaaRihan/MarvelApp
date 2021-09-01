import 'package:flutter/material.dart';

import 'screens/charchters_list_screen.dart';

void main() {
  runApp(MarvelApp());
}

class MarvelApp extends StatefulWidget {
  @override
  _MarvelAppState createState() => _MarvelAppState();
}

class _MarvelAppState extends State<MarvelApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CharchtersListSreen(),
    );
  }
}
