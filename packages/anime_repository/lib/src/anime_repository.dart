import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

import 'models/models.dart';

class HttpException implements Exception {}

class JsonDecodeException implements Exception {}

class HttpRequestFailure implements Exception {
  const HttpRequestFailure(this.statusCode);

  final int statusCode;
}

class AnimeRepository {
  AnimeRepository({
    required http.Client httpClient,
  }) : _httpClient = httpClient;

  final http.Client _httpClient;

  @visibleForTesting
  static const authority = 'www.animecharactersdatabase.com';

  Future<AnimeList> fetchAnimeList() async {
    http.Response? response;
    final animeListUri = Uri.https(
      authority,
      '/api_series_characters.php',
      {"title_wiki_links": ""},
    );

    try {
      response = await _httpClient.get(animeListUri);
    } catch (err) {
      throw HttpException();
    }

    if (response.statusCode != 200) {
      throw HttpRequestFailure(response.statusCode);
    }

    try {
      final body = json.decode(response.body) as Map<String, dynamic>;
      return AnimeList(
        info: body["info"],
        titles: (body["titles"] as List)
            .map(
              (anime) => Anime(
                animeId: anime["anime_id"],
                wikipediaUrl: anime["wikipedia_url"],
              ),
            )
            .toList(),
      );
    } catch (err) {
      throw JsonDecodeException();
    }
  }

  Future<AnimeDetails> getAnimeCharacters(String id) async {
    http.Response? response;
    final animeCharacterslUri = Uri.https(
      authority,
      '/api_series_characters.php',
      {"anime_id": id},
    );

    try {
      response = await _httpClient.get(animeCharacterslUri);
    } catch (err) {
      throw HttpException();
    }

    if (response.statusCode != 200) {
      throw HttpRequestFailure(response.statusCode);
    }

    try {
      final body = json.decode(response.body) as Map<String, dynamic>;
      return AnimeDetails(
        animeId: body["anime_id"],
        animeName: body["anime_name"],
        animeImage: body["anime_image"],
        characters: (body["characters"] as List<dynamic>)
            .map(
              (character) => Character(
                id: character["id"],
                characterImage: character["character_image"],
                gender: character["gender"],
                name: character["name"],
                desc: character["desc"],
              ),
            )
            .toList(),
      );
    } catch (err) {
      throw JsonDecodeException();
    }
  }

  Future<CharacterQuotes> getCharacterQuotes(String characterId) async {
    http.Response? response;
    final characterQuotesUri = Uri.https(
      authority,
      '/api_series_characters.php',
      {"character_quotes": characterId},
    );

    try {
      response = await _httpClient.get(characterQuotesUri);
    } catch (err) {
      throw HttpException();
    }

    if (response.statusCode != 200) {
      throw HttpRequestFailure(response.statusCode);
    }

    try {
      final body = json.decode(response.body) as Map<String, dynamic>;
      return CharacterQuotes(
        animeId: body["anime_id"],
        animeImage: body["anime_image"],
        origin: body["origin"],
        quotes: (body["quotes"] as List<dynamic>)
            .map(
              (quote) => Quote(
                series: quote["SERIES"],
                lineId: quote["LINE_ID"],
                srtId: quote["SRT_ID"],
                epid: quote["EPID"],
                pid: quote["PID"],
                quoteUrl: quote["QUOTE_URL"],
                subLine: quote["SUB_LINE"],
              ),
            )
            .toList(),
        id: body["id"],
        name: body["name"],
        characterImage: body["character_image"],
        gender: body["gender"],
        desc: body["desc"],
      );
    } catch (err) {
      throw JsonDecodeException();
    }
  }
}
