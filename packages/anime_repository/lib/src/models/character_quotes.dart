import 'character.dart';
import 'quote.dart';

class CharacterQuotes extends Character {
  CharacterQuotes({
    this.animeId,
    this.animeImage,
    this.origin,
    this.quotes,
    super.id,
    super.name,
    super.characterImage,
    super.gender,
    super.desc,
  });

  final int? animeId;
  final String? animeImage;
  final String? origin;
  final List<Quote>? quotes;

  @override
  CharacterQuotes copyWith({
    int? animeId,
    String? animeImage,
    String? origin,
    List<Quote>? quotes,
    int? id,
    String? name,
    String? characterImage,
    String? gender,
    String? desc,
  }) {
    return CharacterQuotes(
      animeId: animeId,
      animeImage: animeImage,
      origin: origin,
      quotes: quotes,
      id: id ?? super.id,
      name: name ?? super.name,
      characterImage: characterImage ?? super.characterImage,
      gender: gender ?? super.gender,
      desc: desc ?? super.desc,
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        "anime_id": animeId,
        "anime_image": animeImage,
        "origin": origin,
        "quotes": quotes!
            .map(
              (quote) => quote.toJson(),
            )
            .toList(),
        "id": super.id,
        "name": super.name,
        "character_image": super.characterImage,
        "gender": super.gender,
        "desc": super.desc,
      };

  @override
  List<Object?> get props => [
        animeId,
        animeImage,
        origin,
        quotes,
        super.id,
        super.name,
        super.characterImage,
        super.gender,
        super.desc,
      ];
}
