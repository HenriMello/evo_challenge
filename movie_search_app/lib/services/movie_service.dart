import '../core/api_client.dart';
import '../models/movie.dart';

class MovieService {
  static Future<List<Movie>> searchMovies(String query) async {
    final data = await ApiClient.get('/search/multi', {'query': query});

    List<Movie> results = (data['results'] as List)
        .where((e) => e['media_type'] == 'movie' || e['media_type'] == 'tv')
        .map((e) => Movie.fromJson(e))
        .toList();

    results.sort((a, b) {
      final aYear = a.releaseDate.isNotEmpty ? int.tryParse(a.releaseDate.split('-')[0]) ?? 0 : 0;
      final bYear = b.releaseDate.isNotEmpty ? int.tryParse(b.releaseDate.split('-')[0]) ?? 0 : 0;
      if (aYear != bYear) return aYear.compareTo(bYear);
      return a.title.toLowerCase().compareTo(b.title.toLowerCase());
    });

    return results;
  }

  static Future<Movie> fetchDetails(Movie movie) async {
    final endpoint = movie.mediaType == 'movie'
        ? '/movie/${movie.id}'
        : '/tv/${movie.id}';

    final data = await ApiClient.get(endpoint);

    return movie.copyWithDetails(
      runtime: data['runtime'], 
      numberOfSeasons: data['number_of_seasons'], 
    );
  }
}
