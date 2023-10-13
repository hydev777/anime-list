import 'package:equatable/equatable.dart';

class Anime extends Equatable {
  const Anime({
    this.animeId,
    this.wikipediaUrl,
  });

  final int? animeId;
  final String? wikipediaUrl;

  factory Anime.fromJson(Map<String, dynamic> json) {
    return Anime(
      animeId: json['animeId'] != null ? json['animeId'] as int : null,
      wikipediaUrl:
          json['wikipediaUrl'] != null ? json['wikipediaUrl'] as String : null,
    );
  }

  Anime copyWith({
    int? animeId,
    String? wikipediaUrl,
  }) {
    return Anime(
      animeId: animeId ?? this.animeId,
      wikipediaUrl: wikipediaUrl ?? this.wikipediaUrl,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'anime_id': animeId,
      'wikipedia_url': wikipediaUrl,
    };
  }

  @override
  List<Object?> get props => [
        animeId,
        wikipediaUrl,
      ];
}
