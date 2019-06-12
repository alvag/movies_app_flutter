import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:movies/environments/env.dart';
import 'package:movies/src/models/actor_model.dart';
import 'package:movies/src/models/movie_model.dart';

class MoviesProvider {
  String _baseUrl = 'api.themoviedb.org';
  String _language = 'es-ES';
  int _popularesPage = 0;
  bool _loading = false;

  List<Movie> _populares = new List();

  final _popularesStreamController = StreamController<List<Movie>>.broadcast();

  Function(List<Movie>) get popularesSink =>
      _popularesStreamController.sink.add;

  Stream<List<Movie>> get popularesStream => _popularesStreamController.stream;

  void disposeStreams() {
    _popularesStreamController?.close();
  }

  Future<List<Movie>> _fetchMovies(Uri uri) async {
    http.Response response = await http.get(uri);
    final data = json.decode(response.body);
    return new Movies.fromJsonList(data['results']).items;
  }

  /// Retorna un listado de películas en cartelera
  Future<List<Movie>> getMovies() async {
    final uri = Uri.https(_baseUrl, '3/movie/now_playing',
        {'api_key': TMDB_API_KEY, 'page': '1', 'language': _language});
    return await _fetchMovies(uri);
  }

  Future<List<Movie>> searchMovies(String query) async {
    final uri = Uri.https(_baseUrl, '3/search/movie',
        {'api_key': TMDB_API_KEY, 'language': _language, 'query': query});
    return await _fetchMovies(uri);
  }

  /// Retorna un listado de películas populares
  Future<List<Movie>> getPopularMovies() async {
    if (_loading) {
      return [];
    }

    _loading = true;

    _popularesPage++;

    final uri = Uri.https(_baseUrl, '3/movie/popular', {
      'api_key': TMDB_API_KEY,
      'page': '1',
      'language': _language,
      'page': _popularesPage.toString()
    });

    final response = await _fetchMovies(uri);
    _populares.addAll(response);

    popularesSink(_populares);
    _loading = false;
    return response;
  }

  Future<List<Actor>> getCast(String movieId) async {
    final uri = Uri.https(
        _baseUrl, '3/movie/$movieId/credits', {'api_key': TMDB_API_KEY});

    http.Response response = await http.get(uri);
    final data = json.decode(response.body);
    final cast = new Cast.fromJsonList(data['cast']);
    return cast.actors;
  }
}
