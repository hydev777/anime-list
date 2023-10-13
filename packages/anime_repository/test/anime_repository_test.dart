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

    group("fetch anime details", () {
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
        await subject.getAnime("1");

        verify(
          () => httpClient.get(animesDetailUrl),
        ).called(1);
      });

      test("get anime details", () async {
        final animeDetailsResponse = await subject.getAnime("1");

        expect(
          animeDetailsResponse,
          animeDetails,
        );
      });
    });
  });
}
