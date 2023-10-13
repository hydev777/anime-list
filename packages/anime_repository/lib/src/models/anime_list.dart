// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'anime.dart';

class AnimeList extends Equatable {
  const AnimeList({
    this.info,
    this.titles,
  });

  final String? info;
  final List<Anime>? titles;

  AnimeList copyWith({
    String? info,
    List<Anime>? titles,
  }) {
    return AnimeList(
      info: info ?? this.info,
      titles: titles ?? this.titles,
    );
  }

  Map<String, dynamic> toJson() => {
        "info": info,
        "titles": titles!
            .map(
              (anime) => anime.toJson(),
            )
            .toList(),
      };

  @override
  List<Object?> get props => [
        info,
        titles,
      ];
}
