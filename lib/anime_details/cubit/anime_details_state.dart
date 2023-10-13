// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'anime_details_cubit.dart';

enum AnimeDetailsStatus { initial, loading, success, empty, error }

class AnimeDetailsState extends Equatable {
  const AnimeDetailsState({
    this.animeDetailsStatus,
    this.animeDetails,
  });

  final AnimeDetailsStatus? animeDetailsStatus;
  final AnimeDetails? animeDetails;

  AnimeDetailsState copyWith({
    AnimeDetailsStatus? animeDetailsStatus,
    AnimeDetails? animeDetails,
  }) {
    return AnimeDetailsState(
      animeDetailsStatus: animeDetailsStatus ?? this.animeDetailsStatus,
      animeDetails: animeDetails ?? this.animeDetails,
    );
  }

  @override
  List<Object?> get props => [
        animeDetailsStatus,
        animeDetails,
      ];
}
