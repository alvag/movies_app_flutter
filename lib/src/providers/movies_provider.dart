import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:movies/environments/env.dart';
import 'package:movies/src/models/movie_model.dart';

class MoviesProvider {
  String _baseUrl = 'api.themoviedb.org';
  String _language = 'es-ES';

  Future<List<Movie>> _fetchData(Uri uri) async {
    http.Response response = await http.get(uri);
    final data = json.decode(response.body);
    return new Movies.fromJsonList(data['results']).items;
  }

  /// Retorna un listado de películas en cartelera
  Future<List<Movie>> getMovies() async {
    final uri = Uri.https(_baseUrl, '3/movie/now_playing',
        {'api_key': TMDB_API_KEY, 'page': '1', 'language': _language});
    return await _fetchData(uri);
  }

  /// Retorna un listado de películas populares
  Future<List<Movie>> getPopularMovies() async {
    final uri = Uri.https(_baseUrl, '3/movie/popular',
        {'api_key': TMDB_API_KEY, 'page': '1', 'language': _language});
    return await _fetchData(uri);
  }
}
