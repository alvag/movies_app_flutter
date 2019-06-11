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
        itemBuilder: (BuildContext context, int index) {
          final image = ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: FadeInImage.assetNetwork(
              placeholder: 'assets/images/film-poster-placeholder.png',
              image: movies[index].getPosterImage(),
              fit: BoxFit.cover,
            ),
          );

          return GestureDetector(
            child: image,
            onTap: () {
              Navigator.pushNamed(context, 'details', arguments: movies[index]);
            },
          );
        },
        itemCount: movies.length,
        // pagination: new SwiperPagination(),
        // control: new SwiperControl(),
      ),
    );
  }
}
