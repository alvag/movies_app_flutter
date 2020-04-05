import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import 'package:movies/src/models/movie_model.dart';

class CardSwiper extends StatelessWidget {
  final List<Movie> movies;

  CardSwiper({@required this.movies});

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.only(top: 10.0),
      child: Swiper(
        layout: SwiperLayout.STACK,
        itemWidth: _screenSize.width * 0.7,
        itemHeight: _screenSize.height * 0.5,
        itemCount: movies.length,
        // pagination: new SwiperPagination(),
        // control: new SwiperControl(),
        itemBuilder: (BuildContext context, int index) {
          movies[index].uniqueId = '${movies[index].id}-card';
          final image = Hero(
            tag: movies[index].uniqueId,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage.assetNetwork(
                placeholder: 'assets/images/film-poster-placeholder.png',
                image: movies[index].getPosterImage(),
                fit: BoxFit.cover,
              ),
            ),
          );

          return GestureDetector(
            child: image,
            onTap: () {
              Navigator.pushNamed(context, 'details', arguments: movies[index]);
            },
          );
        },
      ),
    );
  }
}
