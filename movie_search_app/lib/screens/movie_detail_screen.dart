import 'package:flutter/material.dart';
import '../models/movie.dart';
import '../services/movie_service.dart';

class MovieDetailScreen extends StatefulWidget {
  final Movie movie;
  const MovieDetailScreen({super.key, required this.movie});

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  late Movie movie;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    movie = widget.movie;
    loadDetails();
  }

  Future<void> loadDetails() async {
    try {
      final updated = await MovieService.fetchDetails(movie);
      setState(() {
        movie = updated;
        loading = false;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao carregar detalhes: $e')),
      );
      setState(() => loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(movie.title)),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  if (movie.posterPath.isNotEmpty)
                    Image.network(
                      'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                      fit: BoxFit.cover,
                    ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          movie.title,
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          movie.releaseDate.isNotEmpty
                              ? 'Ano: ${movie.releaseDate.split('-')[0]}'
                              : 'Ano desconhecido',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey[400]),
                        ),
                        const SizedBox(height: 8),
                        if (movie.mediaType == 'movie' && movie.runtime != null)
                          Text(
                            'Duração: ${movie.runtime} min',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        if (movie.mediaType == 'tv' && movie.numberOfSeasons != null)
                          Text(
                            'Temporadas: ${movie.numberOfSeasons}',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        const SizedBox(height: 16),
                        Text(
                          'Sinopse:',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          movie.overview,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
