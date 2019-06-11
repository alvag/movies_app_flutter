import 'package:flutter/material.dart';

import 'package:movies/src/models/movie_model.dart';

class MovieHorizontal extends StatelessWidget {
  final List<Movie> movies;
  final Function nextPage;

  MovieHorizontal({@required this.movies, @required this.nextPage});
  final _pageController = new PageController(
    initialPage: 1,
    viewportFraction: 0.3,
  );

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    _pageController.addListener(() {
      if (_pageController.position.pixels >=
          _pageController.position.maxScrollExtent - 200) {
        nextPage();
      }
    });

    return Container(
      height: _screenSize.height * 0.25,
      child: PageView.builder(
        pageSnapping: false,
        controller: _pageController,
        // children: _movieCards(context),
        itemCount: movies.length,
        itemBuilder: (context, i) {
          return _card(context, movies[i]);
        },
      ),
    );
  }

  Widget _card(BuildContext context, Movie movie) {
    final _screenSize = MediaQuery.of(context).size;

    final cardMovie = Container(
      margin: EdgeInsets.only(right: 15.0),
      child: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: FadeInImage.assetNetwork(
              placeholder: 'assets/images/film-poster-placeholder.png',
              image: movie.getPosterImage(),
              fit: BoxFit.cover,
              height: _screenSize.height * 0.2,
            ),
          ),
          SizedBox(height: 5.0),
          Text(
            movie.title,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.caption,
          )
        ],
      ),
    );

    return GestureDetector(
      child: cardMovie,
      onTap: () {
        Navigator.pushNamed(context, 'details', arguments: movie);
      },
    );
  }

/*
  List<Widget> _movieCards(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    return movies.map((movie) {
      return Container(
        margin: EdgeInsets.only(right: 15.0),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: FadeInImage.assetNetwork(
                placeholder: 'assets/images/film-poster-placeholder.png',
                image: movie.getPosterImage(),
                fit: BoxFit.cover,
                height: _screenSize.height * 0.2,
              ),
            ),
            SizedBox(height: 5.0),
            Text(
              movie.title,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.caption,
            )
          ],
        ),
      );
    }).toList();
  }
  */
}
