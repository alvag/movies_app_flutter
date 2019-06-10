import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:movies/environments/env.dart';
import 'package:movies/src/models/movie_model.dart';

class MoviesProvider {
  String _baseUrl = 'api.themoviedb.org';
  String _language = 'es-ES';

  Future<dynamic> _fetchData(Uri uri) async {
    http.Response response = await http.get(uri);
    return json.decode(response.body);
  }

  Future<List<Movie>> getMovies() async {
    final uri = Uri.https(_baseUrl, '3/movie/now_playing',
        {'api_key': TMDB_API_KEY, 'page': '1', 'language': _language});

    final data = await _fetchData(uri);
    return new Movies.fromJsonList(data['results']).items;
  }
}
