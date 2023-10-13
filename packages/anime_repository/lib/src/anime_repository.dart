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
    final animeUri = Uri.https(
      authority,
      '/api_series_characters.php',
      {"title_wiki_links": ""},
    );

    try {
      response = await _httpClient.get(animeUri);
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

  Future<AnimeDetails> getAnime(String id) async {
    http.Response? response;
    final animeUri = Uri.https(
      authority,
      '/api_series_characters.php',
      {"anime_id": id},
    );

    try {
      response = await _httpClient.get(animeUri);
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
}
