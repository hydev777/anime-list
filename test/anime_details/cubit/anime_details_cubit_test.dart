import 'package:anime_list/anime_details/cubit/anime_details_cubit.dart';
import 'package:anime_repository/anime_repository.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:bloc_test/bloc_test.dart';

class MockAnimeRepository extends Mock implements AnimeRepository {}

void main() {
  group('AnimeDetailsCubit', () {
    const animeDetails = AnimeDetails(
      animeName: "Welcome to Pia Carrot!! GO ~ Grand Opening",
      animeImage: "https://ami.animecharactersdatabase.com/productimages/1.jpg",
      animeId: "1",
      characters: [
        Character(
          id: 11865,
          characterImage:
              "https://ami.animecharactersdatabase.com/uploads/chars/thumbs/200/4758-1144475819.jpg",
          gender: "Female",
          name: "Ayano Kunugi",
          desc:
              "Ayano Kunugi is a character from the H-Game Welcome to Pia Carrot!! GO ~ Grand Opening.",
        ),
        Character(
          id: 2,
          characterImage:
              "https://ami.animecharactersdatabase.com/uploads/chars/thumbs/200/4758-904869381.jpg",
          gender: "Female",
          name: "Chihiro Midou",
          desc:
              "Chihiro Midou is a character from the H-Game Welcome to Pia Carrot!! GO ~ Grand Opening.",
        ),
      ],
    );

    late AnimeRepository animeRepository;

    setUp(() {
      animeRepository = MockAnimeRepository();
    });

    blocTest<AnimeDetailsCubit, AnimeDetailsState>(
      "emit error when repository throws exception",
      build: () {
        when(() => animeRepository.fetchAnimeList()).thenThrow(Exception());

        return AnimeDetailsCubit(
          animeRepository: animeRepository,
        );
      },
      act: (bloc) => bloc.fetchAnimeDetails("1"),
      expect: () => [
        const AnimeDetailsState(
          animeDetailsStatus: AnimeDetailsStatus.loading,
        ),
        const AnimeDetailsState(
          animeDetailsStatus: AnimeDetailsStatus.error,
        )
      ],
    );

    blocTest<AnimeDetailsCubit, AnimeDetailsState>(
      "anime details is complete",
      build: () {
        when(() => animeRepository.getAnime("1"))
            .thenAnswer((_) async => animeDetails);

        return AnimeDetailsCubit(
          animeRepository: animeRepository,
        );
      },
      act: (bloc) => bloc.fetchAnimeDetails("1"),
      expect: () => [
        const AnimeDetailsState(
          animeDetailsStatus: AnimeDetailsStatus.loading,
        ),
        const AnimeDetailsState(
          animeDetailsStatus: AnimeDetailsStatus.success,
          animeDetails: animeDetails,
        )
      ],
    );
  });
}
