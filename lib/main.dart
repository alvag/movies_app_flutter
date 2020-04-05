import 'package:flutter/material.dart';

import 'package:movies/src/pages/home_page.dart';
import 'package:movies/src/pages/movie_details.dart';

void main() => runApp(MoviesApp());

class MoviesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Películas',
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        'details': (context) => MovieDetails(),
      },
    );
  }
}