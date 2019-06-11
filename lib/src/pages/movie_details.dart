import 'package:flutter/material.dart';
import 'package:movies/src/models/movie_model.dart';

class MovieDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Movie movie = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: Center(
        child: CustomScrollView(
          slivers: <Widget>[
            _crearAppBar(movie),
          ],
        ),
      ),
    );
  }

  Widget _crearAppBar(Movie movie) {
    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.indigoAccent,
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          movie.title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
          ),
        ),
        background: FadeInImage.assetNetwork(
          placeholder: 'assets/images/loading.gif',
          image: movie.getBackgroundImage(),
          fit: BoxFit.cover,
          fadeInDuration: Duration(seconds: 1),
        ),
      ),
    );
  }
}
