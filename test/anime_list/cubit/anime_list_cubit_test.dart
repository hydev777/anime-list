import 'package:anime_list/anime_list/cubit/anime_list_cubit.dart';
import 'package:anime_repository/anime_repository.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:bloc_test/bloc_test.dart';

class MockAnimeRepository extends Mock implements AnimeRepository {}

void main() {
  group('AnimeListCubit', () {
    final animesList = AnimeList(
      info: "Listing of IDs with Wikipedia links",
      titles: List.generate(
        10,
        (i) => Anime(
          animeId: i,
          wikipediaUrl: 'http://en.wikipedia.org/wiki/Welcome_to_Pia_Carrot',
        ),
      ),
    );

    late AnimeRepository animeRepository;

    setUp(() {
      animeRepository = MockAnimeRepository();
    });

    blocTest<AnimeListCubit, AnimeListState>(
      "emit error when repository throws exception",
      build: () {
        when(() => animeRepository.fetchAnimeList()).thenThrow(Exception());

        return AnimeListCubit(
          animeRepository: animeRepository,
        );
      },
      act: (bloc) => bloc.fetchAnimeList(),
      expect: () => [
        const AnimeListState(
          animeListStatus: AnimeListStatus.loading,
        ),
        const AnimeListState(
          animeListStatus: AnimeListStatus.error,
        )
      ],
    );

    blocTest<AnimeListCubit, AnimeListState>(
      "anime list is empty",
      build: () {
        when(() => animeRepository.fetchAnimeList()).thenAnswer(
          (_) async => const AnimeList(info: "", titles: []),
        );

        return AnimeListCubit(
          animeRepository: animeRepository,
        );
      },
      act: (bloc) => bloc.fetchAnimeList(),
      expect: () => [
        const AnimeListState(
          animeListStatus: AnimeListStatus.loading,
        ),
        const AnimeListState(
          animeListStatus: AnimeListStatus.empty,
        )
      ],
    );

    blocTest<AnimeListCubit, AnimeListState>(
      "anime list is complete",
      build: () {
        when(() => animeRepository.fetchAnimeList()).thenAnswer(
          (_) async => animesList,
        );

        return AnimeListCubit(
          animeRepository: animeRepository,
        );
      },
      act: (bloc) => bloc.fetchAnimeList(),
      expect: () => [
        const AnimeListState(
          animeListStatus: AnimeListStatus.loading,
        ),
        AnimeListState(
          animeListStatus: AnimeListStatus.success,
          animeList: animesList.titles,
        )
      ],
    );
  });
}
