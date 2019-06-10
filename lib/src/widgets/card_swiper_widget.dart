import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:movies/src/models/movie_model.dart';

class CardSwiper extends StatelessWidget {
  final List<dynamic> cardsList;

  CardSwiper({@required this.cardsList});

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
          Movie movie = cardsList[index];
          return ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: FadeInImage.assetNetwork(
              placeholder: 'assets/images/film-poster-placeholder.png',
              image: movie.getPosterImage(),
              fit: BoxFit.cover,
            ),
          );
        },
        itemCount: cardsList.length,
        // pagination: new SwiperPagination(),
        // control: new SwiperControl(),
      ),
    );
  }
}
