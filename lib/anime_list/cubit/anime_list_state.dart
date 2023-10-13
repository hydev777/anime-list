part of 'anime_list_cubit.dart';

enum AnimeListStatus { initial, loading, success, empty, error }

class AnimeListState extends Equatable {
  const AnimeListState({
    this.animeList,
    this.animeListStatus,
  });

  final List<Anime>? animeList;
  final AnimeListStatus? animeListStatus;

  AnimeListState copyWith({
    List<Anime>? animeList,
    AnimeListStatus? animeListStatus,
  }) {
    return AnimeListState(
      animeList: animeList ?? this.animeList,
      animeListStatus: animeListStatus ?? this.animeListStatus,
    );
  }

  @override
  List<Object?> get props => [
        animeList,
        animeListStatus,
      ];
}
