class Movie {
  final int id;
  final String title;
  final String overview;
  final String posterPath;
  final String releaseDate;
  final String mediaType;
  final int? runtime;
  final int? numberOfSeasons; 
  Movie({
    required this.id,
    required this.title,
    required this.overview,
    required this.posterPath,
    required this.releaseDate,
    required this.mediaType,
    this.runtime,
    this.numberOfSeasons,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      title: json['title'] ?? json['name'] ?? 'Sem título',
      overview: json['overview'] ?? 'Sem descrição',
      posterPath: json['poster_path'] ?? '',
      releaseDate: json['release_date'] ?? json['first_air_date'] ?? '',
      mediaType: json['media_type'] ?? 'movie',
    );
  }

  Movie copyWithDetails({
    int? runtime,
    int? numberOfSeasons,
  }) {
    return Movie(
      id: id,
      title: title,
      overview: overview,
      posterPath: posterPath,
      releaseDate: releaseDate,
      mediaType: mediaType,
      runtime: runtime ?? this.runtime,
      numberOfSeasons: numberOfSeasons ?? this.numberOfSeasons,
    );
  }
}
