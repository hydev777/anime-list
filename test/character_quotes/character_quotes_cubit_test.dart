import 'package:anime_list/character_quotes/cubit/character_quotes_cubit.dart';
import 'package:anime_repository/anime_repository.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:bloc_test/bloc_test.dart';

class MockAnimeRepository extends Mock implements AnimeRepository {}

void main() {
  group("CharacterQuotesCubit", () {
    final characterQuotes = CharacterQuotes(
      id: 1,
      animeId: 2,
      animeImage:
          "https://ami.animecharactersdatabase.com/productimages/u/5524-835244276.jpg",
      characterImage:
          "https://ami.animecharactersdatabase.com/uploads/chars/thumbs/200/5524-813006538.jpg",
      origin: "Problem children are coming from another world, aren't they?",
      gender: "Female",
      name: "Asuka Kudou",
      desc:
          "Asuka Kudou is a character from the Anime Problem children are coming from another world, aren't they?.",
      quotes: List.generate(
        4,
        (index) => const Quote(
          series:
              "Problem children are coming from another world, aren't they?",
          lineId: 3,
          srtId: 4,
          epid: 5,
          pid: 6,
          quoteUrl:
              "https://www.animecharactersdatabase.com/animequotes.php?line_id=5515",
          subLine: "Hey, you.",
        ),
      ),
    );

    late AnimeRepository animeRepository;

    setUp(() {
      animeRepository = MockAnimeRepository();
    });

    blocTest<CharacterQuotesCubit, CharacterQuotesState>(
      "emit error when repository throws exception",
      build: () {
        when(() => animeRepository.fetchAnimeList()).thenThrow(Exception());

        return CharacterQuotesCubit(
          animeRepository: animeRepository,
        );
      },
      act: (bloc) => bloc.onFetchCharacterQuotes("1"),
      expect: () => [
        const CharacterQuotesState(
          characterQuotesStatus: CharacterQuotesStatus.loading,
        ),
        const CharacterQuotesState(
          characterQuotesStatus: CharacterQuotesStatus.error,
        )
      ],
    );

    blocTest<CharacterQuotesCubit, CharacterQuotesState>(
      "anime list is complete",
      build: () {
        when(() => animeRepository.getCharacterQuotes("1")).thenAnswer(
          (_) async => characterQuotes,
        );

        return CharacterQuotesCubit(
          animeRepository: animeRepository,
        );
      },
      act: (bloc) => bloc.onFetchCharacterQuotes("1"),
      expect: () => [
        const CharacterQuotesState(
          characterQuotesStatus: CharacterQuotesStatus.loading,
        ),
        CharacterQuotesState(
          characterQuotesStatus: CharacterQuotesStatus.success,
          characterQuotes: characterQuotes,
        )
      ],
    );
  });
}
