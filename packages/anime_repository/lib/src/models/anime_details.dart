import 'package:equatable/equatable.dart';

import 'character.dart';

class AnimeDetails extends Equatable {
  const AnimeDetails({
    this.animeName,
    this.animeImage,
    this.animeId,
    this.characters,
  });

  final String? animeName;
  final String? animeImage;
  final String? animeId;
  final List<Character>? characters;

  AnimeDetails copyWith({
    String? animeName,
    String? animeImage,
    String? animeId,
    List<Character>? characters,
  }) {
    return AnimeDetails(
      animeName: animeName ?? this.animeName,
      animeImage: animeImage ?? this.animeImage,
      animeId: animeId ?? this.animeId,
      characters: characters ?? this.characters,
    );
  }

  Map<String, dynamic> toJson() => {
        "anime_name": animeName,
        "anime_image": animeImage,
        "anime_id": animeId,
        "characters": characters!
            .map(
              (character) => character.toJson(),
            )
            .toList(),
      };

  @override
  List<Object?> get props => [
        animeName,
        animeImage,
        animeId,
        characters,
      ];
}
