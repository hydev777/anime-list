import 'dart:convert';

import 'package:anime_repository/src/anime_repository.dart';
import 'package:anime_repository/src/models/models.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  late Uri animesUrl;
  late Uri animesDetailUrl;
  late Uri characterQuotesUrl;

  group("Anime", () {
    late http.Client httpClient;
    late AnimeRepository subject;

    final animeList = AnimeList(
      info: "Listing of IDs with Wikipedia links",
      titles: List.generate(
        10,
        (i) => Anime(
          animeId: i,
          wikipediaUrl: 'http://en.wikipedia.org/wiki/Welcome_to_Pia_Carrot',
        ),
      ),
    );

    final animeDetails = AnimeDetails(
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
        (index) => Quote(
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

    setUp(() {
      httpClient = MockHttpClient();
      subject = AnimeRepository(httpClient: httpClient);
      animesUrl = Uri.https(
        AnimeRepository.authority,
        "/api_series_characters.php",
        {"title_wiki_links": ""},
      );
      animesDetailUrl = Uri.https(
        AnimeRepository.authority,
        "/api_series_characters.php",
        {"anime_id": "1"},
      );
      characterQuotesUrl = Uri.https(
        AnimeRepository.authority,
        "/api_series_characters.php",
        {"character_quotes": "1"},
      );
    });

    group('fetch anime list', () {
      setUp(() {
        when(() => httpClient.get(animesUrl)).thenAnswer(
          (_) async => http.Response(
            json.encode(animeList.toJson()),
            200,
          ),
        );
      });

      test("throws HttpException when http client throws exception", () {
        when(() => httpClient.get(animesUrl)).thenThrow(Exception());

        expect(
          () => subject.fetchAnimeList(),
          throwsA(
            isA<HttpException>(),
          ),
        );
      });

      test("500 response status", () {
        when(() => httpClient.get(animesUrl)).thenAnswer(
          (_) async => http.Response("Server error", 500),
        );
      });

      test("400 response status", () {
        when(() => httpClient.get(animesUrl)).thenAnswer(
          (_) async => http.Response("Something went wrong", 400),
        );
      });

      test("makes correct request", () async {
        await subject.fetchAnimeList();

        verify(
          () => httpClient.get(animesUrl),
        ).called(1);
      });

      test("fetch anime list", () async {
        final animelistResponse = await subject.fetchAnimeList();

        expect(
          animelistResponse,
          animeList,
        );
      });
    });

    group("fetch anime characters", () {
      setUp(() {
        when(() => httpClient.get(animesDetailUrl)).thenAnswer(
          (_) async => http.Response(
            json.encode(animeDetails.toJson()),
            200,
          ),
        );
      });

      test("throws HttpException when http client throws exception", () {
        when(() => httpClient.get(animesDetailUrl)).thenThrow(Exception());

        expect(
          () => subject.fetchAnimeList(),
          throwsA(
            isA<HttpException>(),
          ),
        );
      });

      test("500 response status", () {
        when(() => httpClient.get(animesDetailUrl)).thenAnswer(
          (_) async => http.Response("Server error", 500),
        );
      });

      test("400 response status", () {
        when(() => httpClient.get(animesDetailUrl)).thenAnswer(
          (_) async => http.Response("Something went wrong", 400),
        );
      });

      test("makes correct request", () async {
        await subject.getAnimeCharacters("1");

        verify(
          () => httpClient.get(animesDetailUrl),
        ).called(1);
      });

      test("get anime details", () async {
        final animeDetailsResponse = await subject.getAnimeCharacters("1");

        expect(
          animeDetailsResponse,
          animeDetails,
        );
      });
    });

    group("fetch character quotes", () {
      setUp(() {
        when(() => httpClient.get(characterQuotesUrl)).thenAnswer(
          (_) async => http.Response(
            json.encode(characterQuotes.toJson()),
            200,
          ),
        );
      });

      test("throws HttpException when http client throws exception", () {
        when(() => httpClient.get(characterQuotesUrl)).thenThrow(Exception());

        expect(
          () => subject.getCharacterQuotes("1"),
          throwsA(
            isA<HttpException>(),
          ),
        );
      });

      test("500 response status", () {
        when(() => httpClient.get(characterQuotesUrl)).thenAnswer(
          (_) async => http.Response("Server error", 500),
        );
      });

      test("400 response status", () {
        when(() => httpClient.get(characterQuotesUrl)).thenAnswer(
          (_) async => http.Response("Something went wrong", 400),
        );
      });

      test("makes correct request", () async {
        await subject.getCharacterQuotes("1");

        verify(
          () => httpClient.get(characterQuotesUrl),
        ).called(1);
      });

      test("get character quotes", () async {
        final characterQuotesResponse = await subject.getCharacterQuotes("1");

        expect(
          characterQuotesResponse,
          characterQuotes,
        );
      });
    });
  });
}
